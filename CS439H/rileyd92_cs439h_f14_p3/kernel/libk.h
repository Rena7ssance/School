#ifndef _LIBK_H_
#define _LIBK_H_

#include <stdarg.h>
#include "sink.h"

class K {
public:
    static void snprintf (Sink<char>& sink, long maxlen, const char *fmt, ...);
    static void vsnprintf (Sink<char>& sink, long maxlen, const char *fmt, va_list arg);
    static long strlen(const char* str);
    static int isdigit(int c);
    template <typename T> static T&& move(T& x);
};

#endif
