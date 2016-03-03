#include "init.h"
#include "process.h"

class Noise : public Process {
    uint32_t n;      /* array elements */
    uint32_t iters;  /* iterations */
    Noise* prev;
public:
    Noise(const char *name, uint32_t n, uint32_t iters, Noise* prev) : Process(name),
        n(n), iters(iters), prev(prev)
    {
    }
    uint32_t v(uint32_t i) {
        return n - i - 1;
    }
    void run() {
        uint32_t *p = (uint32_t *) 0x80000000;
        for (uint32_t i = 0; i < n; i++) {
            if (p[i] != 0) {
                Debug::panic("p[%u] == %u",i,p[i]);
            }
            p[i] = v(i);
        }
        uint32_t sum = 0;
        for (uint32_t iter = 0; iter < iters; iter++) {
            for (uint32_t i = 0; i < n; i++) {
                sum += p[i];
            }
        }

        if (prev) {
            prev->doneEvent.wait();
        }

        for (uint32_t i = 0; i < n; i++) {
            if (p[i] != v(i)) {
                Debug::panic("p[%u] == %u",i,p[i]);
            }
        }
        trace("n=%u, iters=%u, sum=%u, expected=%u",n,iters,sum,(n*(n-1))/2 * iters);
    }
};

class Faulting : public Process {
public:
    Faulting() : Process("bad") {}
    void run() {
        int* p = 0;
        *p = 100;
    }
};

Init::Init() : Process("init") {
}

void Init::run() {
    Process::trace("starting");

    Process *faulting = new Faulting();
    faulting->start();

    Noise *p0 = new Noise("p0", 1000, 100000, nullptr);
    Noise *p1 = new Noise("p1", 10000, 10000, p0);
    Noise *p2 = new Noise("p2", 100000, 1000, p1);

    p2->start();
    p1->start();
    p0->start();

    p2->doneEvent.wait();

    faulting->doneEvent.wait();
    trace("%s",faulting->killMsg);

    Process::trace("done");
    Debug::shutdown("Good bye!");
}
