#include "file.h"

int32_t File::readFully(int32_t n, void* buffer) {
    int32_t togo = n;
    while (togo > 0) {
        int32_t c = read(togo,buffer);
        if (c <= 0) return c;
        togo -= c;
        buffer = (void*) (((char*) buffer) + c);
    }
    return n;
}
