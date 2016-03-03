#ifndef _SINK_H_
#define _SINK_H_

template<typename T> class Sink {
public:
    virtual void put(T v) = 0;
};

#endif
