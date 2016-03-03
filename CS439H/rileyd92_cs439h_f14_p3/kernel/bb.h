#ifndef _BB_H_
#define _BB_H_

#include "process.h"
#include "debug.h"

//
// Bounded buffer using semaphores
//
template<typename T> class BB {
    T *arr;
    int n;
    int head;
    int tail;
    Semaphore nFull;
    Semaphore nEmpty;
    Semaphore mutex;
public:
    BB(int n) : arr(new T[n]),n(n),head(0),tail(0),nFull(0),nEmpty(n),mutex(1) {
    }

    void put(T v) {
        nEmpty.down();
        mutex.down();

        arr[tail] = v;
        tail++;

        if(tail >= n) {
          tail = 0;
        }

        mutex.up();
        nFull.up();
    }

    T get() {
        nFull.down();
        mutex.down();

        T val = arr[head];
        head++;

        if(head >= n) {
          head = 0;
        }

        mutex.up();
        nEmpty.up();

        return val;
    }

};

#endif
