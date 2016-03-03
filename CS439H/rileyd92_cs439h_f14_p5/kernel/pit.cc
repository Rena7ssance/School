#include "pit.h"
#include "machine.h"
#include "debug.h"
#include "idle.h"

/* The pit will be programmed to generate an interrupts at
   a frequency of FREQ/divide MHz */

/* divide is a 16 bit unsigned int */

//#define FREQ 1.193182
//#define DIVIDE 12
//#define DIVIDE 11931

constexpr uint32_t FREQ = 1193182;
uint32_t Pit::jiffies = 0;
uint32_t Pit::hz = 0;
extern IdleProcess* idle;


uint32_t Pit::seconds() {
    return jiffies / hz;
}

void Pit::init(uint32_t hz) {
     uint32_t d = 1193182 / hz;
     Debug::printf("Pit::init freq=%dHZ, divide=%d\n",hz,d);
     if ((d & 0xffff) != d) {
         Debug::panic("Pit::init d=%d doesn't fit in 16 bits",d);
     }
     Pit::hz = FREQ / d;
     Debug::printf("Pit::init requested:%dHz, actual:%dHz\n",hz,Pit::hz);
     pit_do_init(d);
}

void Pit::handler() {
    //CHECK TIMER

    if(Process::current == idle) {
      Process::idleJiffies++;
    }

    Timer* current = Process::timers;
    Timer* prev = Process::timers;
    Timer* next;

    if(current) {
      while(current != nullptr) {

        if(current->target <= Pit::seconds()) {

          Process* a = current->waiting.removeHead();
          a->makeReady();

          if(current == Process::timers) {

            if(current->next) {
              Process::timers = current->next;
            }
            else {
              Process::timers = nullptr;
            }

          }
          else {

            next = current->next;

            if(next) {
              prev->next = next;
            }
            else {
              prev->next = nullptr;
            }

          }

        }

        if(current->next) {
          prev = current;
          current = current->next;
        }
        else {
          break;
        }

      }
    }

    jiffies ++;
}
