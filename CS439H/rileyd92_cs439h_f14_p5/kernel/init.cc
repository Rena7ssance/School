#include "init.h"
#include "process.h"
#include "bb.h"
#include "pic.h"
#include "pit.h"
#include "machine.h"
#include "semaphore.h"

class Forever : public Process {

public:
    uint32_t counter;
    void run() {
        while(true) counter++;
    }
};

class Background : public Process {
public:
    void run() {
        while(true) {
            Process* p = new Forever();
            p->start();
            Process::sleepFor(1);
            p->kill("x");
            p->doneEvent.wait();
            Process::sleepFor(1);
            delete p;
        }
    }
};

/* A process that generates noise */
class Noise : public Process {
    uint32_t n;
    char ch;
    uint32_t base;
public:
    Noise(const char *name, uint32_t base, char ch, uint32_t n) : Process(name),
                                n(n), ch(ch), base(base)
    {
    }
    void run() {
        for (uint32_t i = base; i<n; i+=2) {
            Process::sleepUntil(i);
            Debug::printf("%c",ch++);
        }
    }
};

Init::Init() : Process("init") {
}

void Init::run() {
    Process::trace("starting");
    Process::trace("will run for about 18 seconds");

    Noise *n0 = new Noise("lower",1,'a',10);
    Noise *n1 = new Noise("upper",2,'A',20);
    Process* back = new Background();
    back->start();

    n1->start();
    n0->start();

    n0->doneEvent.wait();
    n1->doneEvent.wait();

    back->kill("y");
    back->doneEvent.wait();

    Debug::printf("\n");
    Process::trace("done");
    if ((Process::idleJiffies >= (8 * Pit::hz)) && (Process::idleJiffies <= (10 * Pit::hz))) {
        Debug::printf("idle jiffies is in range\n");
    } else {
        Debug::printf("idle jiffies out of range %d\n",Process::idleJiffies);
    }
    Debug::shutdown("Good bye!");
}
