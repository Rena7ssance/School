#ifndef _IDT_H_
#define _IDT_H_

#include "stdint.h"
#include "mmu.h"

#define IDT_COUNT 256

extern Descriptor idt[];

//extern TableDescriptor idtDesc;

extern void idt_init(void);
extern void idt_addInterruptHandler(int index, uint32_t handler);

#endif
