#ifndef _FILE_H_
#define _FILE_H_

#include "stdint.h"

/* Base class for file oeprations
   Defines the file interface
*/

class File {
public:
    /*
     * read up to n bytes from the file and place them in the given buffer,
     *   advance current position by number of bytes actually read
     *
     * returns:
     *    <= 0 : error
     *    >0 : number of bytes actually read (<= n)
     */
    virtual int32_t read(int32_t n, void* buffer) = 0;

    /*
     * read exactly n bytes from the file and place them in the given buffer,
     *    advance current position by n
     *
     * returns:
     *    < 0 : error
     *    0 : end of file
     *    > 0 : n
     */
    virtual int32_t readFully(int32_t n, void* buffer);

    /*
     * set current position to off
     */
    virtual int32_t seek(int32_t off) = 0;
};

#endif
