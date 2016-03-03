#include "idt.h"
#include "gdt.h"
#include "machine.h"

void idt_init(void) {
    //setTrapDescriptor(&idt[14],kernelCS,(uint32_t)pageFaultHandler,0);
}

void idt_addInterruptHandler(int index, uint32_t handler) {
    setInterruptDescriptor(&idt[index],kernelCS, handler, 0);
}
