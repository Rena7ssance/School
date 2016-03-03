#ifndef _VMM_H_
#define _VMM_H_

#include "stdint.h"

typedef struct {
  uint32_t entries[1024];
} page_directory;

// The physical memory interface
class PhysMem {
public:
    static constexpr uint32_t FRAME_SIZE = (1 << 12);
    static void init(uint32_t start, uint32_t end);

    /* allocate a frame */
    static uint32_t alloc();

    /* free a frame */
    static void free(uint32_t);
};

class AddressSpace {

public:
    page_directory *pd;
    AddressSpace();
    void punmap(uint32_t va);
    void pmap(uint32_t va, uint32_t pa, bool forUser, bool forWrite);
    void activate();
    void handlePageFault(uint32_t va);
};

#endif
