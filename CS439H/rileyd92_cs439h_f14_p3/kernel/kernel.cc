#include "debug.h"
#include "machine.h"
#include "u8250.h"
#include "heap.h"
#include "init.h"

extern "C"
void kernelMain(void) {
    U8250 uart;
    Debug::sink = &uart;   /* debug output goes to the serial port */
    Debug::debugAll = false;

    Heap::init((void*)0x100000,0x100000);

    Process::init();
    Process::DEBUG->off();

    Debug::printf("\n\n\n");
    Process::trace("Welcome to K439");

    new Init();

    Process::yield();

    Debug::panic("Should never return");
}
