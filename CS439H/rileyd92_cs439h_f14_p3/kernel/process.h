#ifndef _PROCESS_H_
#define _PROCESS_H_

#include "queue.h"
#include "debug.h"

class Process {

    // kernel stack size in longs
    static size_t STACK_LONGS;

    // The current process, nullptr -> none
    static Process *current;                  

    // the ready queue
    static SimpleQueue<Process*> readyQueue;

    // next process id
    static int nextId;

    // process id
    int id;

    // The process state
    enum State {
        READY,
        RUNNING,
        BLOCKED,
        TERMINATED
    };

    // The current state
    State state;

    // kernel stack for this process
    long *stack;

    // A place for context switching to save the kernel ESP
    long kesp;

    // set to true if the process is killed
    bool isKilled;

    // the death message sent by the killer
    const char* killMsg;

public:
    // an optional name
    const char* name;

    // used to print debug messages
    static Debug* DEBUG;

    // called to initialize the process subsystem
    static void init();

    // create a process with an optional name
    // the new process inserts itself in the ready queue
    Process(const char* name = nullptr);

    // destructor
    virtual ~Process();

    // implement by subclass, does the work of the process
    virtual void run() = 0;

    // called when the process is about to exit, either:
    //    - by returning from run()
    //    - by calling Process::exit()
    //    - by being killed
    // last code run by the process
    virtual void onExit() {
        Process::trace("onExit");
    }

    // called when the process is dispatched after being killed
    // onExit will be called after returning from onKill
    virtual void onKill(const char* kmsg) {
        Process::trace("onKill: %s",kmsg);
    }

    // called when the current process wants to yield the CPU
    //    - the current process (if not null) goes into the ready queue
    //    - a process is picked to run form the ready queue
    //    - if no other process is ready, the yielding process
    //      runs again
    // 
    // A process that wants to exit can call yield after setting current
    // process to null
    static void yield();

    // called when the current process wants to block
    //    - the current process is marked BLOCKED and added to the given queue
    //    - a process is picked to run from the ready queue
    //    - if no other process is ready, we panic
    static void yield(Queue<Process*> *q);

    // called when the current process wants to exit
    //    goes into the terminated state
    static void exit();

    // make the given process ready
    void makeReady();

    // check the state
    bool isTerminated();
    bool isReady();
    bool isRunning();
    bool isBlocked();

    // causes the process to exit after calling handleDeath when it tries
    // to run next. Done immediately if a process does it to itself.
    void kill(const char* msg);
    static void checkKilled();

    // print a trace message with the process identity prefixed to it
    void static vtrace(const char* msg, va_list ap);
    void static trace(const char* msg, ...);
};

class Semaphore {
    int count;
    SimpleQueue<Process*> waiting;
public:
    Semaphore(int count);
    void down();
    void up();
};

#endif
