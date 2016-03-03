#include "semaphore.h"
#include "process.h"
#include "atomic.h"
#include "pic.h"

Semaphore::Semaphore(int count) : count(count), waiting() {
}

void Semaphore::down() {
    if (Process::current == 0) {
        Debug::panic("down without process");
    }
    Process::disable();
    if (count == 0) {
        Process::yield(&waiting); // yield unlock the queue
    } else {
        count --;
    }
    Process::enable();
}

void Semaphore::up() {
    Process::disable();
    if (waiting.isEmpty()) {
        count ++;
    } else {
        Process *p = waiting.removeHead();
        p->makeReady();
    }
    Process::enable();
}
