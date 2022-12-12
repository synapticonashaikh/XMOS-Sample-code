#include <stdio.h>
#include <xcore/hwtimer.h>
#include <xcore/triggerable.h>
#include <xcore/port.h>
#include <xcore/interrupt.h>
#include <xcore/interrupt_wrappers.h>
DEFINE_INTERRUPT_PERMITTED(interrupt_handlers, void, interruptable_task, void)
{
  hwtimer_t timer = hwtimer_alloc();
  interrupt_unmask_all();
  for (;;)
  {
    puts("I'm still running.");
    hwtimer_delay(timer, 100000000);
  }
  interrupt_mask_all();
  hwtimer_free(timer);
}
DEFINE_INTERRUPT_CALLBACK(interrupt_handlers, interrupt_task, button)
{
  port_set_trigger_in_not_equal(*(port_t *)button, 1);
  printf("(%x) caused an interrupt\n", *(port_t *)button);
}

int main(void)
{
  port_t button1 = XS1_PORT_1P;
  port_enable(button1);
  triggerable_setup_interrupt_callback(button1, &button1, INTERRUPT_CALLBACK(interrupt_task));
  port_set_trigger_in_not_equal(button1, 1);
  triggerable_enable_trigger(button1);
  INTERRUPT_PERMITTED(interruptable_task)();
  printf("shouldn't be here!\n\r");
  port_disable(button1);
}