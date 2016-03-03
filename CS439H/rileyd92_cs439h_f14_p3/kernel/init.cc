#include "init.h"
#include "process.h"
#include "bb.h"

/* A process that generates lots of noise */
class Noise : public Process {
    int count;
    int n;
public:
    Noise(const char *name, int n) : Process(name), count(0), n(n) {}
    void run() {
        for (int i=0; i<n; i++) {
            Process::trace("%d",i);
            Process::yield();
        }
    }
    void handleDeath(const char* kmsg) {
        Process::trace("someone killed me : %s",kmsg);
    }
};

/* A process that calls Process::exit */
class EarlyExit : public Process {
public:
    EarlyExit() : Process("EarlyExit") {}
    void run() {
        Process::trace("before exit");
        Process::exit();
        Process::trace("should never get here ????????");
    }
};

/* A process that kills kill on itself */
class EarlyDeath : public Process {
public:
    EarlyDeath() : Process("EarlyDeath") {}
    void run() {
        Process::trace("before kill");
        kill("it was me");
        Process::trace("should never get here ????????");
    }
};
        
/* A process that blocks on a semaphore */
class Wait : public Process {
    Semaphore *s;
public:
    Wait(Semaphore *s) : Process("Wait"), s(s) {}
    void run() {
        int i = 0;

        while (1) {
            Process::trace("%d : about to call down",i);
            s->down();
            Process::trace("%d : back from calling down",i);
            i++;
        }
    }
};

/* Wait for the given process to temrinate */
void waitingFor(Process *p) {
    while (!p->isTerminated()) {
        Process::trace("waiting for %s",p->name ? p->name : "?");
        Process::yield();
    }
    Process::trace("deleting %s",p->name ? p->name : "?");
    delete p;
}

/* put values in a bounded buffer */
class Producer : public Process {
    BB<int> *bb;
    int n;
public:
    Producer(BB<int>* bb, int n) : Process("producer"), bb(bb), n(n) {}
    void send(int x) {
        Process::trace("calling bb->put %d",x);
        bb->put(x);
        Process::trace("back from bb->put");
    }
    void run() {
        for (int i=0; i<n; i++) {
            send(i);
        }
        send(-1);
    }
};

/* get values from a bounded buffer */
class Consumer : public Process {
    BB<int> *bb;
public:
    int recv() {
        Process::trace("calling bb->get()");
        int x = bb->get();
        Process::trace("back from bb->get() %d",x);
        return x;
    }
    Consumer(BB<int> *bb) : Process("consumer"), bb(bb) {}
    void run() {
        int x;
        do {
            x = recv();
        } while (x != -1);
    }
};
        
        

Init::Init() : Process("init") {
}

void Init::run() {
    Process::trace("starting");
    Process *a = new Noise("A",3);
    Process *b = new Noise("B",5);
    Process *c = new Noise("C",1000000);
    Process *d = new Noise("D",1000000);
    new EarlyExit();
    new EarlyDeath();
    c->kill("before running");

    waitingFor(a);
    waitingFor(b);
    waitingFor(c);
   
    d->kill("after running");

    waitingFor(d);

    Semaphore *s0 = new Semaphore(2);
    Process *w = new Wait(s0);
    Process::yield();
    Process::trace("about to call up");
    s0->up();
    Process::yield();
    Process::trace("about to call up again");
    s0->up();
    w->kill("go away");
    waitingFor(w);

    BB<int> *bb = new BB<int>(3);
    Producer *producer = new Producer(bb,10);
    Consumer *consumer = new Consumer(bb);

    waitingFor(producer);
    waitingFor(consumer);
    
    Process::trace("done");
}

