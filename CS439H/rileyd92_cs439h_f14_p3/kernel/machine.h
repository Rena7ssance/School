#ifndef _MACHINE_H_
#define _MACHINE_H_

#include "stdint.h"

extern "C" void contextSwitch(long *placeToSaveEsp, long nextEsp);
extern "C" int eflags();

extern "C" void pit_do_init(int divide);

extern "C" int inb(int port);
extern "C" int inl(int port);
extern "C" void outb(int port, int val);

extern "C" void ltr(uint32_t tr);

extern "C" void pageFaultHandler();

extern "C" uint32_t getcr0();
extern "C" uint32_t getcr3();
extern "C" void invlpg(uint32_t);


extern "C" void cli(void);
extern "C" void sti(void);

extern "C" void irq0(void);
extern "C" void irq1(void);
extern "C" void irq2(void);
extern "C" void irq3(void);
extern "C" void irq4(void);
extern "C" void irq5(void);
extern "C" void irq6(void);
extern "C" void irq7(void);
extern "C" void irq8(void);
extern "C" void irq9(void);
extern "C" void irq10(void);
extern "C" void irq11(void);
extern "C" void irq12(void);
extern "C" void irq13(void);
extern "C" void irq14(void);
extern "C" void irq15(void);

#endif
