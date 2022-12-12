#include <xs1.h>
#include <platform.h>
#include <stdio.h>
#include <stdint.h>
#include <print.h>
#include "interrupt.h"
#include <hwtimer.h>
  
#define PERIOD_10NS 100000000 
hwtimer_t g_Timer;

void arm_timer_interrupt(void)
{
    unsigned time;
    DISABLE_INTERRUPTS( );
    asm volatile("setc res[%0], %1"::"r"(g_Timer),"r"(XS1_SETC_COND_NONE));
    g_Timer :> time;
    time += PERIOD_10NS;
    asm volatile("setd res[%0], %1"::"r"(g_Timer),"r"(time));
    asm volatile("setc res[%0], %1"::"r"(g_Timer),"r"(XS1_SETC_COND_AFTER));
}    

//#pragma select handler
void timer_handler(void)
{
    arm_timer_interrupt();
    printstr("Inside timer isr ...\n");
 }                                                                                                                                                                                                              

void InfiniteLoop(void)
{
    arm_timer_interrupt( );
    set_interrupt_handler(timer_handler, 1, g_Timer, 0);
    while(1) {
        for (int count=0; count<0xFFFFFF; count++) {}; //do something
        printstr("Inside main loop\n");
    }
}

int main( )
{
    InfiniteLoop( );
    return 0;
}
