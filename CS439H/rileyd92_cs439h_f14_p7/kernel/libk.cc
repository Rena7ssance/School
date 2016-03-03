#include "libk.h"
#include "debug.h"
#include "process.h"
#include "machine.h"

void K::bzero(void* p, size_t sz) {
    memset(p,0,sz);
}

long K::strlen(const char* str) {
    long n = 0;
    while (*str++ != 0) n++;
    return n;
}

int K::isdigit(int c) {
    return (c >= '0') && (c <= '9');
}

template <typename T> T&& move(T& t) {
    return (T&&)t;
}

extern "C" void __cxa_pure_virtual() {
    Debug::panic("__cxa_pure_virtual called\n");
}
