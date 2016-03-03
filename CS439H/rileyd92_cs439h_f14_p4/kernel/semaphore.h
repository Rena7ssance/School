#ifndef _SEMAPHORE_H_
#define _SEMAPHORE_H_

#include "queue.h"
#include "debug.h"

class Process;

class Semaphore {
    int count;
    SimpleQueue<Process*> waiting;
public:
    Semaphore(int count);
    void down();
    void up();
};

class Event {
    Semaphore mutex;
public:
    Event() : mutex(0){
    }
    void wait() {
        mutex.down();
        mutex.up();
    }
    void signal() {
        mutex.up();
    }
};

#endif
