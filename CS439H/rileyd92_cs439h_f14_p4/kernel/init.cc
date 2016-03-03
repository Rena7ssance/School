#include "init.h"
#include "process.h"
#include "bb.h"
#include "pic.h"
#include "pit.h"
#include "machine.h"
#include "semaphore.h"

class Nothing : public Process {
public:

    Nothing() {}

    void run() {
    }
};

/* A process that generates noise */
class Noise : public Process {
    uint32_t n;
    Noise *after;
    char ch;
    Event started;
public:
    Noise(const char *name, Noise* after, char b, uint32_t n) : Process(name),
                                n(n), after(after), ch(b)
    {
    }
    void run() {
        if (after) {
            after->started.wait();
        }
        uint32_t start = Pit::seconds();
        trace("will run for %d seconds",n-2);
        started.signal();
        uint32_t target = getId();
        Nothing *p = 0;
        while (target < n) {
            uint32_t t = Pit::seconds() - start;
            if (t == target) {
                Debug::printf("%c",ch++);
                target += 2;
            }
            if (p) {
                if (p->isTerminated()) {
                    delete p;
                    p = 0;
                }
            }
            if (p == 0) {
                p = new Nothing();
                p->start();
            }
        }
    }
};

Init::Init() : Process("init") {
}

void Init::run() {
    Process::trace("starting");

    Noise *n0 = new Noise("lower",0,'a',10);
    Noise *n1 = new Noise("upper",n0,'A',20);
    n1->start();
    n0->start();

    n0->doneEvent.wait();
    n1->doneEvent.wait();

    Debug::printf("\n");
    Process::trace("done");
}
