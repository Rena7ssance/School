#include "vmm.h"
#include "machine.h"
#include "process.h"
#include "mmu.h"
#include "idt.h"
#include "gdt.h"
#include "libk.h"

uint32_t avail;
uint32_t limit;

///////////////////////////////////////////////////////////////////////////
//RESOURCES
//SARAH MAGLIOCCA: HAD CONVERSATIONS ABOUT STRATEGIES FOR MEMORY MANAGEMENT
///////////////////////////////////////////////////////////////////////////

void PhysMem::init(uint32_t start, uint32_t end) {
    Process::disable();
    //SETS UP INTERNAL LINKED LIST
    avail = start;
    limit = end;

    uint32_t *temp = (uint32_t*)start;
    while(*temp < end) {
      *temp = (int)temp + 4096;
      temp = (uint32_t*)*temp;
    }

    /* register the page fault handler */
    setTrapDescriptor(&idt[14],kernelCS,(uint32_t)pageFaultHandler,0);
    Process::enable();
}

uint32_t PhysMem::alloc() {
    Process::disable();
    uint32_t returnVal = avail;
    if(avail < limit) {
      avail = *(uint32_t*)avail;
    }
    else {
      //NO MORE MEMORY
      if(Process::readyQueue->isEmpty()) {
        Process::idleProcess = Process::current;
      }
      else {
        //Process::idleProcess = Process::current;
        Process::current->kill("No more memory");
      }
    }
    Process::enable();
    return returnVal;
}

void PhysMem::free(uint32_t p) {
    Process::disable();
    if(p < avail) {
      //NEED TO MOVE AVAIL
      uint32_t tempo = avail;
      avail = p;
      uint32_t *aP = (uint32_t*)avail;
      *aP = (int)tempo;
    }
    else {

      uint32_t* bf = (uint32_t*)avail;

      while((uint32_t)(uint32_t*)*bf < p) {
        bf = (uint32_t*)*bf;
      }

      uint32_t* af = (uint32_t*)*bf;

      *bf = p;

      uint32_t *aP = (uint32_t*)p;

      *aP = (uint32_t)af;

    }
    Process::enable();
}

AddressSpace::AddressSpace() {
    pd = (page_directory*)PhysMem::alloc();
    for(int i = 0; i < 1024; i++) {
      pd->entries[i] = 0 | 2;
    }

    page_directory *pt = (page_directory*)PhysMem::alloc();
    int i;

    for(i = 0x1000; i < 0x00400000; i+=4096) {
      pt->entries[i/4096] = i | 3;
    }
    pd->entries[0] = (uint32_t)pt;
    pd->entries[0] |= 3;
}

void AddressSpace::punmap(uint32_t va) {
    if(va >= 0x00400000){
      uint32_t p1 = (va & 0xfffff000) >> 22;
      uint32_t p2 = ((va & 0xfffff000) >> 12) & 0x3ff;
      page_directory *page_table = (page_directory*)(0xfffff000 & (uint32_t)pd->entries[p1]);
      uint32_t pa = (0xfffff000 & (uint32_t)page_table->entries[p2]);
      PhysMem::free(pa);
    }
}

void AddressSpace::pmap(uint32_t va, uint32_t pa, bool forUser, bool forWrite) {
    uint32_t p1 = (va & 0xfffff000) >> 22;
    uint32_t p2 = ((va & 0xfffff000) >> 12) & 0x3ff;

    if(!((uint32_t)pd->entries[p1] & 0x1)) {
      page_directory *p = (page_directory*)PhysMem::alloc();
      pd->entries[p1] = (uint32_t)p;
      pd->entries[p1] |= 3;
    }

    page_directory *page_table = (page_directory*)(0xfffff000 & (uint32_t)pd->entries[p1]);

    page_table->entries[p2] = pa;
    page_table->entries[p2] |= 3;
}

void AddressSpace::activate() {
    Process::disable();
    vmm_on((uint32_t)pd);
    Process::enable();
}

void AddressSpace::handlePageFault(uint32_t va) {
    Process::disable();
    if(va <= 0x1000) {
      if(Process::readyQueue->isEmpty()) {
        //MAKE IT IDLE PROCESS
        Process::idleProcess = Process::current;
      }
      else {
        //KILL PROCESS
        Process::idleProcess = Process::current;
        Process::current->kill("seg0");
      }
    }
    else if((va > 0x1000) && (va < 0x00400000)) {
      uint32_t pa = PhysMem::alloc();
      pmap(va, pa, true, true);
    }
    else {
      uint32_t pa = PhysMem::alloc();
      memset((uint32_t*)pa, 0, 4096);
      pmap(va, pa, true, true);
    }
    Process::enable();
}

extern "C" void vmm_pageFault(uintptr_t va) {
    Process* proc = Process::current;
    if (!proc) {
        Debug::panic("page fault @ 0x%08x without current process",va);
    }
    proc->addressSpace.handlePageFault(va);
}
