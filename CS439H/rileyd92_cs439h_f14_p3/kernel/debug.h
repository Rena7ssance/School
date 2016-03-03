#ifndef _DEBUG_H_
#define _DEBUG_H_

#include <stdarg.h>
#include "sink.h"
#include "stdint.h"

class Debug {
    const char* what;
    bool flag;
public:
    static bool debugAll;
    static Sink<char> *sink;
    static void vprintf(const char* fmt, va_list ap);
    static void printf(const char* fmt, ...);
    static void vpanic(const char* fmt, va_list ap);
    static void panic(const char* fmt, ...);
    static void missing(const char* file, int line, const char* msg);

    Debug(const char* what) : what(what), flag(false) {
    }
    
    void vdebug(const char* fmt, va_list ap);
    void debug(const char* fmt, ...);

    void on() { flag = true; }
    void off() { flag = false; }
};

#define MISSING(msg) Debug::missing(__FILE__,__LINE__,msg)

#endif
