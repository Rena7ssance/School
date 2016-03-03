#include "debug.h"
#include "machine.h"
#include "u8250.h"
#include "heap.h"
#include "init.h"
#include "pic.h"
#include "pit.h"
//#include "idt.h"
#include "kbd.h"
#include "vmm.h"

extern "C"
void kernelMain(void) {
    /* Here is the state:

          - we're running on the initial stack
          - there is no heap
          - interrupts are disabled
          - there are no processes

       Here is the plan:

          - direct debug output to COM1 so we can express ourselves
          - initialize the heap before someone starts saying new or malloc
          - initialize the interrupts controller and vectors
          - start the interval-timer ticking
          - create the first process and yield to it. This will implicitly
            enable interrupts
          - go away
    */
       
      
    Pic::off();             // make sure interrupts are disabled

    /* redirect debug output to COM1 */
    U8250 uart;
    Debug::init(&uart);
    Debug::debugAll = false;
    Debug::printf("\nWhat just happened? Who am I? Why am I here?\n");
    Debug::printf("I am K439, welcome to my world\n");

    /* Initialize the heap */
    Heap::init((void*)0x100000,0x100000);
    Debug::printf("I have a heap\n");

    /* Make the rest of memory available for VM */
    PhysMem::init(0x200000,0x400000);

    /* Initialize the process subsystem */
    Process::init();
    Process::DEBUG->off();
    Process::trace("Process tracing enabled");

    Pic::init();                // initialize the PIC, still disabled

    Keyboard::init();           // initialize the keyboard

    Pit::init(1000 /* Hz */);   // enable the PIT, interrupts still disabled

    /* Create the Primordial process */
    (new Init())->start();

    /* Yield to it, it will start running with interrupts enabled */
    Process::trace("Let there be processes");
    Process::yield();

    Debug::panic("The impossible has happened");
}
