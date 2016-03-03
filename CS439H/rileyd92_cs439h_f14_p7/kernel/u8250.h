#ifndef _U8250_H_
#define _U8250_H_

/* 8250 */

#include "io.h"

class U8250 : public OutputStream<char> {
public:
    virtual void put(char ch);
};

#endif
