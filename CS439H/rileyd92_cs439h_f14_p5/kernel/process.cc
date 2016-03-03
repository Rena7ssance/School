#include "process.h"
#include "machine.h"
#include "debug.h"
#include "pic.h"
#include "pit.h"
#include "semaphore.h"
#include "idle.h"

/* global process declarations */
Debug* Process::DEBUG;                       // the debug channel
size_t Process::STACK_LONGS = 1024 * 2;      // default kernel stack size
SimpleQueue<Process*> *Process::readyQueue;  // the ready queue
Process* Process::current;                   // the current process
IdleProcess* idle = nullptr;
Atomic32 Process::nextId;                     // next process ID
Semaphore *Process::traceMutex;
Timer* Process::timers = nullptr;            // pending timers
uint32_t Process::idleJiffies = 0;            // idle jiffies

void Process::init() {
    DEBUG = new Debug("Process");
    readyQueue = new SimpleQueue<Process*>();
    traceMutex = new Semaphore(1);
}

void Process::checkKilled() {
    Process *me = Process::current;
    if (me) {
        if (me->isKilled) {
            me->onKill(me->killMsg);
            Process::exit();
        }
    }
}

void Process::entry() {
    checkKilled();
    run();
    exit();
}

extern "C" void runProcess() {
    Process::current->entry();
}

/* A bit of room to detect stack overflow without
   corrupting neighbors */
#define FUDGE 128

Process::Process(const char* name) : name(name) {
    DEBUG->debug("Process::Process %p",this);
    id = nextId.getThenAdd(1);
    iDepth = 0;
    iCount = 0;
    isKilled = false;
    killMsg = nullptr;
    disableCount = 0;
    stack = new long[FUDGE + STACK_LONGS];
    if (stack == 0) {
        Debug::panic("can't allocate stack");
    }
    stack = &stack[FUDGE];
    int idx = STACK_LONGS;
    stack[--idx] = 0;
    stack[--idx] = (long) runProcess;
    stack[--idx] = 0; /* %ebx */
    stack[--idx] = 0; /* %esi */
    stack[--idx] = 0; /* edi */
    stack[--idx] = 0; /* ebp */
    kesp = (long) &stack[idx];
}

Process::~Process() {
    DEBUG->debug("Process::~Process %p",this);
    if (stack) {
        delete[] (stack - FUDGE);
        stack = 0;
    }
}

void Process::start() {
    makeReady();
}

void Process::kill(const char* msg) {
    Process::disable();
    if (!isKilled) {
        isKilled = true;
        killMsg = msg;
    }
    Process::enable();
    checkKilled();
}

bool Process::isTerminated() {
    return state == TERMINATED;
}

bool Process::isRunning() {
    return state == RUNNING;
}

bool Process::isBlocked() {
    return state == BLOCKED;
}

bool Process::isReady() {
    return state == READY;
}

void Process::makeReady() {
    disable();
    state = READY;
    readyQueue->addTail(this);
    enable();
}

/******************/
/* Static methods */
/******************/

void Process::vtrace(const char* msg, va_list ap) {
    Process *me = current;
    if (me != 0) {
        traceMutex->down();
    }

    Debug::printf("[");
    if (me) {
        if (me->name) {
            Debug::printf("%s",me->name);
        }
        Debug::printf("#%d",me->id);
    }
    Debug::printf("] ");
    Debug::vprintf(msg,ap);
    Debug::printf("\n");

    if (me != 0) {
        traceMutex->up();
    }
}

void Process::trace(const char* msg, ...) {
    va_list ap;
    va_start(ap,msg);
    vtrace(msg,ap);
    va_end(ap);
}

void Process::exit() {
    Process* p = current;
    DEBUG->debug("Process::exit() %p",p);

    if (p) {
        p->onExit();
        Process::disable();
        p->state = TERMINATED;
        current = nullptr;
        p->doneEvent.signal();
        yield();
        Debug::panic("should never get here");
        Process::enable();
    }
}

/* switch to the next process */
void Process::dispatch(Process *prev) {
    state = RUNNING;

    uint32_t stackBottom = (uint32_t) &stack[STACK_LONGS];
    uint32_t stackBytes = stackBottom - (uint32_t) kesp;
    uint32_t stackLongs = stackBytes / 4;

    if (stackLongs >= STACK_LONGS) {
        Debug::panic("stack for %s is too big, %d bytes, iDepth:%d iCount:%d",name,stackBytes,iDepth,iCount);
    }

    if (this != prev) {
        current = this;
        contextSwitch(
            prev ? &prev->kesp : 0, kesp, (disableCount == 0) ? (1<<9) : 0);
    }
    checkKilled();
}

void Process::yield(Queue<Process*> *q) {
    Process::disable();
    Process* me = current;
    if (me) {
        if (q) {
            /* a queue is specified, I'm blocking on that queue */
            if (me->iDepth != 0) {
                Debug::panic("blocking while iDepth = %d",me->iDepth);
            }
            me->state = BLOCKED;
            q->addTail(me);
        } else {
            /* no queue is specified, put me on the ready queue */
            if(me != idle) {
              me->makeReady();
            }
        }
    }

    Process* next;

    if (readyQueue->isEmpty()) {
        if(idle == nullptr) {
          idle = new IdleProcess();
        }
        next = idle;
    } else {
        next = readyQueue->removeHead();
    }

    next->dispatch(me);
    Process::enable();
}

void Process::yield() {
    yield(nullptr);
}

/*******************/
/* The timer class */
/*******************/

void Process::sleepUntil(uint32_t second) {
    Process::disable();

    Timer* a = new Timer();
    a->target = second;
    a->next = nullptr;
    //set next to end of timer linked list

    Timer* b = Process::timers;
    if(b != nullptr) {
      while(b != nullptr) {
        if(b->next) {
          b = b->next;
        }
        else {
          break;
        }
      }
      b->next = a;

    } else {

      Process::timers = a;
    }

    yield(&a->waiting);

    Process::enable();
}

void Process::sleepFor(uint32_t seconds) {
    Process::disable();
    Process::sleepUntil(Pit::seconds() + seconds);
    Process::enable();
}

void Process::disable() {
    Pic::off();
    Process* me = current;
    if (me) {
        me->disableCount ++;
    }
}

void Process::enable() {
    Process* me = current;
    /* It is meaningless to enable interrupts without
       a current process */
    if (me) {
        uint32_t c = me->disableCount;
        if (c == 0) {
            Debug::panic("disable = %d",c);
        } else if (c == 1) {
            me->disableCount = 0;
            Pic::on();
        } else {
            me->disableCount --;
        }
    }
}

void Process::startIrq() {
    Process* me = Process::current;
    if (current == 0) {
        Debug::panic("startIrq with no process");
        return;
    }
    me->iCount ++;
    me->iDepth ++;
    if (me->disableCount != 0) {
        Debug::panic("disableCount = %d",me->disableCount);
    }
    me->disableCount = 1;
}

void Process::endIrq() {
    Process* me = Process::current;
    if (me == 0) {
        return;
    }
    me->iDepth --;
    if (me->disableCount != 1) {
        Debug::panic("disableCount = %d",me->disableCount);
    }
    me->disableCount = 0;
}