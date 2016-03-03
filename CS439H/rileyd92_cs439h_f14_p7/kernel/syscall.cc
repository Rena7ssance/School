#include "syscall.h"
#include "machine.h"
#include "idt.h"
#include "process.h"

void Syscall::init(void) {
    IDT::addTrapHandler(100,(uint32_t)syscallTrap,3);
}

extern "C" void syscallHandler(long num, long a0, long a1) {
    Process::trace("syscall(%d,%d,%d)",num,a0,a1);
    if(num == 0) {
      Process::exit();
    }
}
