#include "init.h"
#include "ide.h"
#include "elf.h"
#include "machine.h"

//REFERENCES
//Sarah Magliocca and I discussed the semantics of the elf file as well as the most efficient strategies for organizing data
//
//Mark Lindberg and I discussed the semantics of the elf file, as well as the most efficient strategies for reading the data,
//as well as what was required to pass the test cases

Init::Init() : Process("init") {
}

void loadElf(int device) {
    int sector = 0;

    Elf32_Ehdr* elf = new Elf32_Ehdr();

    char* ebuff = new char[512];

    ide_readSector(device, sector, ebuff);

    elf = ((Elf32_Ehdr*)ebuff);

    if(elf->e_machine != 3) {
      //WRONG MACHINE
      Debug::panic("Invalid Machine Type.");
    }
    else  {
      if(elf->e_version != 1) {
        //WRONG VERSION
        Debug::panic("Invalid Version.");
      }
      else {
        if(elf->e_type != 2) {
          //WRONG TYPE
          Debug::panic("Invalid File Type.");
        }
        else{

          if(elf->e_entry < 0x80000000) {
            //INVALID ENTRY POINT
            Debug::panic("Invalid Entry Point.");
          }
          else {
            //CORRECT CREDENTIALS
            int offset = elf->e_phoff;
            for(int i = 0; i < elf->e_phnum; i++) {
                Elf32_Phdr* phdr = reinterpret_cast<Elf32_Phdr*>(&ebuff[elf->e_phoff + i*elf->e_phentsize]);
                offset += elf->e_phentsize;
                if(phdr->p_type == 1) {
                  char* buffer = new char[512];
                  char* resultBuffer = new char[phdr->p_memsz];
                  uint32_t sector = phdr->p_offset >> 9;
                  uint32_t offsetInSector = (phdr->p_offset & 511);
                  int index;
                  ide_readSector(device,sector,(void*)buffer);
                  for(index = 0; index < (int)phdr->p_filesz; index++) {
                    if(offsetInSector == 512) {
                      sector++;
                      ide_readSector(device,sector,(void*)buffer);
                      offsetInSector = 0;
                    }
                    resultBuffer[index] = buffer[offsetInSector];
                    offsetInSector++;
                  }
                  while(index < (int)phdr->p_memsz) {
                    resultBuffer[index] = 0;
                    index++;
                  }
                  //LOAD BUFFER INTO MEMORY
                  memcpy((void*)phdr->p_vaddr,(void*)resultBuffer,phdr->p_filesz);
                }
            }
            switchToUser(elf->e_entry, 0xfffffff0);
          }
        }
      }
    }
}

void Init::run() {
    Process::trace("loading user code");

    loadElf(3);

    Debug::shutdown("The impossible has happened!");
}
