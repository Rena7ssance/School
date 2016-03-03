#include "idle.h"

void IdleProcess::run(void) {
    while (true) {
        Process::disable();
        if (!Process::readyQueue->isEmpty()) {
            Debug::panic("idle process running when other processes are ready");
        }
        Process::enable();
        __asm__ __volatile__ ("hlt");
    }
}
