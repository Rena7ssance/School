#ifndef _IDLE_H_
#define _IDLE_H_

#include "process.h"

/* The idle process */

class IdleProcess : public Process {
public:
    virtual void run();
};

#endif
