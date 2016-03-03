#ifndef _SEMAPHORE_H_
#define _SEMAPHORE_H_

#include "queue.h"

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
    Semaphore status;
public:
    Event() : status(0) {}
    void wait() {
        status.down();
        status.up();
    }
    void signal() {
        status.up();
    }
};

#endif
