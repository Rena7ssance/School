#include "process.h"
#include "machine.h"
#include "debug.h"

/*
REFERENCES:

C++ function pointer tutorial: http://www.cprogramming.com/tutorial/function-pointers.html

*/


/* global process declarations */
Debug* Process::DEBUG;                      // the debug channel
size_t Process::STACK_LONGS = 1024 * 2;     // default kernel stack size
SimpleQueue<Process*> Process::readyQueue;  // the ready queue
Process* Process::current;                  // the current process
int Process::nextId = 0;                    // next process ID

void Process::init() {
    DEBUG = new Debug("Process");
}

/* called when a process is activated, causes the process to exit
   if it has been killed */
void Process::checkKilled() {
    Process *me = Process::current;
    if (me) {
        if (me->isKilled) {
            me->onKill(me->killMsg);
            Process::exit();
        }
    }
}

extern "C" void runProcess(Process* th) {
    Process::checkKilled();
    th->run();
    Process::exit();
}

Process::Process(const char* name) : name(name) {
    DEBUG->debug("Process::Process %p",this);
    id = nextId ++;
    isKilled = false;
    killMsg = nullptr;
    stack = new long[STACK_LONGS];

    //INITIALIZE THE STACK

    stack[STACK_LONGS-1] = (long int)this;

    stack[STACK_LONGS-3] = (long int)&runProcess; //POINTER TO runProcess

    kesp = (long int)&stack[STACK_LONGS-8];

    makeReady();
}

Process::~Process() {
    DEBUG->debug("Process::~Process %p",this);
    if (stack) {
        delete[] stack;
        stack = 0;
    }
}

void Process::kill(const char* msg) {
    isKilled = true;
    killMsg = msg;
    if (this == current) {
        onKill(msg);
        Process::exit();
    }
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
    state = READY;
    readyQueue.addTail(this);
}

/******************/
/* Static methods */
/******************/

void Process::vtrace(const char* msg, va_list ap) {
    Process *me = current;
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
        p->state = TERMINATED;
        current = nullptr;
        yield();
    }
}

void Process::yield(Queue<Process*> *q) {
    DEBUG->debug("Process::yield() %p",current);
    Process* me = current;
    if (me) {
        if (q) {
            /* a queue is specified, I'm blocking on that queue */
            q->addTail(me);
            me->state = BLOCKED;
        } else {
            /* no queue is specified, put me on the ready queue */
            me->makeReady();
        }
    }

    if (readyQueue.isEmpty()) {
        Debug::panic("nothing to do");
        return;
    }

    Process* next = readyQueue.removeHead();
    DEBUG->debug("Process::yield next is %p",next);

    next->state = RUNNING;

    /* no switching required */
    if (me == next) return;

    current = next;

    DEBUG->debug("contextSwitch from %p to %p",me,next);
    contextSwitch(me ? &me->kesp : 0, next->kesp);
    checkKilled();
}

void Process::yield() {
    yield(nullptr);
}


/*************/
/* Semaphore */
/*************/

/* ignoring concurrency issues for now */

Semaphore::Semaphore(int count) : count(count) {
}

void Semaphore::down() {
    if(count > 0) {
      count--;
    }
    else {
      //BLOCK PROCESS
      Process::yield(&this->waiting);
    }
}

void Semaphore::up() {
    if(waiting.isEmpty()) {
      count++;
    }
    else {
      //MOVE PROCESS TO READY QUEUE
      if(!waiting.isEmpty()) {
        Process *p = waiting.removeHead();
        p->makeReady();
      }
    }
}
