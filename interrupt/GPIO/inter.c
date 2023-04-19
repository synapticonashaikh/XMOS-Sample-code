/**************************************************************************************
 **************************************************************************************
 ______________________________________________________________________________________

  Company:
	Synapticon GmbH (https://www.synapticon.com/)
 ______________________________________________________________________________________

  File Name:
	parallel.xc
 ______________________________________________________________________________________

  Summary:
    This file contains the source code for printing "Hello world" on the terminal.
 ______________________________________________________________________________________

  Description:
	This file contains the source code for a self-practice task by Synapticon GmbH. 
    It implements the logic of the application's requirements, and it may call API 
    routines from a different section of the code, such as drivers, system services, 
    and middleware (if applicable). However, at present, this code is not calling 
    any of the system-specified APIs (such as the "USARTInitialize" and "TimerTasks"
    functions) of any of the modules in the system. To make the code development 
    environment-friendly, the majority of the code shall be using self-created drivers.

 **************************************************************************************
 **************************************************************************************/

 /**************************************************************************************
   No-Copyright (c):
	 No copyrights are being imposed on these software files. Information shall have
	 to be freely available for the rapid development of science to benefit humanity.
	 When the information is free, this is not a barrier to their progress. Therefore,
	 I, Aatif Shaikh, license you the right to use, modify, copy and distribute this
	 software however you desire.

	 Note*
	 Software and documentation are provided "as is" without warranty of any kind,
	 either express or implied, including without limitation, any warranty of
	 merchantability, title, non-infringement and fitness for a particular purpose.
	 In no event shall, I (Aatif Shaikh) liable or obligated under contract,
	 negligence, strict liability, contribution, breach of warranty, or other legal
	 equitable theory any direct or indirect damages or expenses including but not
	 limited to any incidental, special, indirect, punitive or consequential damages,
	 lost profits or lost data, cost of procurement of substitute goods, technology,
	 services, or any claims by third parties (including but not limited to any
	 defence thereof), or other similar costs.

  ************************************************************************************/

  /************************************************************************************
  ______                                            __      __                                     
 /      \                                          |  \    |  \                                    
|  $$$$$$\ __    __  _______    ______    ______  _| $$_    \$$  _______   ______   _______        
| $$___\$$|  \  |  \|       \  |      \  /      \|   $$ \  |  \ /       \ /      \ |       \       
 \$$    \ | $$  | $$| $$$$$$$\  \$$$$$$\|  $$$$$$\\$$$$$$  | $$|  $$$$$$$|  $$$$$$\| $$$$$$$\      
 _\$$$$$$\| $$  | $$| $$  | $$ /      $$| $$  | $$ | $$ __ | $$| $$      | $$  | $$| $$  | $$      
|  \__| $$| $$__/ $$| $$  | $$|  $$$$$$$| $$__/ $$ | $$|  \| $$| $$_____ | $$__/ $$| $$  | $$      
 \$$    $$ \$$    $$| $$  | $$ \$$    $$| $$    $$  \$$  $$| $$ \$$     \ \$$    $$| $$  | $$      
  \$$$$$$  _\$$$$$$$ \$$   \$$  \$$$$$$$| $$$$$$$    \$$$$  \$$  \$$$$$$$  \$$$$$$  \$$   \$$      
          |  \__| $$                    | $$                                                       
           \$$    $$                    | $$                                                       
            \$$$$$$                      \$$                                                       
                          ______                 __        __    __                                
                         /      \               |  \      |  \  |  \                               
                        |  $$$$$$\ ______ ____  | $$____  | $$  | $$                               
                        | $$ __\$$|      \    \ | $$    \ | $$__| $$                               
                        | $$|    \| $$$$$$\$$$$\| $$$$$$$\| $$    $$                               
                        | $$ \$$$$| $$ | $$ | $$| $$  | $$| $$$$$$$$                               
                        | $$__| $$| $$ | $$ | $$| $$__/ $$| $$  | $$                               
                         \$$    $$| $$ | $$ | $$| $$    $$| $$  | $$                               
                          \$$$$$$  \$$  \$$  \$$ \$$$$$$$  \$$   \$$                               
                                                                                                   
                                                                                                                                                                                                   
		        In order to be irreplaceable, one must always be different
  *************************************************************************************/

/* ----------------------------------------------------------------------------
 *                           Macros
 * ----------------------------------------------------------------------------
*/
/* ----------------------------------------------------------------------------
 *                           Includes
 * ----------------------------------------------------------------------------
*/
  #include <stdio.h>
  #include <xcore/triggerable.h>
  #include <xcore/port.h>
  #include <xcore/interrupt.h>
  #include <xcore/interrupt_wrappers.h>
  #include "header.h"
  
/* ----------------------------------------------------------------------------
 *                           External Function
 * ----------------------------------------------------------------------------
*/ 
/* ----------------------------------------------------------------------------
 *                           GLOBAL VARIABLE DECLARATION
 * ----------------------------------------------------------------------------
*/

  extern port_t button1;
  uint8_t RisingFallingEdge;  //current code generates on rising edge!
  uint8_t uifeedback,uiStatus;

/* ----------------------------------------------------------------------------
 *                           Fnction Definitions
 * ----------------------------------------------------------------------------
*/
/***********************************************************************
 * Function Name: Function1 
 * Arguments	  : void
 * Return Type	: void
 * Details	    : A callback function
 * *********************************************************************/
void CallbackFunction(void)
{
    static int CallbackCount = RESET;
    CallbackCount++;
  	printf ("CALLBACK FUNCTION=%d\n\r",CallbackCount);
}

/***********************************************************************
 * Function Name: DEFINE_INTERRUPT_PERMITTED 
 * Arguments	  : 
 * Return Type	: 
 * Details	    : 
 * *********************************************************************/
DEFINE_INTERRUPT_PERMITTED(interrupt_handlers, void, interruptable_task, void)
{
  interrupt_unmask_all( ); 
  //interrupt_mask_all( );
}
/***********************************************************************
 * Function Name: DEFINE_INTERRUPT_CALLBACK 
 * Arguments	  : 
 * Return Type	: 
 * Details	    : 
 * *********************************************************************/
DEFINE_INTERRUPT_CALLBACK (interrupt_handlers, interrupt_task, button)
{
  //To manipulate the interrupt trigger to get the interrupt on the rising edge only.
   RisingFallingEdge = !RisingFallingEdge;
  port_set_trigger_in_not_equal(button1, RisingFallingEdge); //change the trigger for the port/ pin
  uifeedback = port_peek(button1); //read the current status

  if (( uifeedback == SET ) 
  &&  ( uiStatus == RESET ))
      { uiStatus  =   SET;

      }

  else 
  if (( uifeedback == RESET ) 
  &&  ( uiStatus   ==   SET )) 
      { uiStatus    = RESET; 
        CallbackFunction( );      
      }
}

/***********************************************************************
 * Function Name: FnGpioRead 
 * Arguments	  : void
 * Return Type	: void
 * Details	    : 
 * *********************************************************************/
int FnGpioRead(port_t PortVar)
{ return port_peek(PortVar); }

/***********************************************************************
 * Function Name: GPIOINTRWrapper 
 * Arguments	  : void
 * Return Type	: void
 * Details	    : 
 * *********************************************************************/
void GPIOINTRWrapper(void)
{ INTERRUPT_PERMITTED(interruptable_task)( ); }
/***********************************************************************
 * Function Name: GPIOInterrupt 
 * Arguments	  : void
 * Return Type	: void
 * Details	    : 
 * *********************************************************************/
void GPIOInterrupt(void)
{
  port_enable(button1);
  triggerable_setup_interrupt_callback
  (button1, &button1, INTERRUPT_CALLBACK(interrupt_task));
  port_set_trigger_in_not_equal(button1, RESET);
  port_clear_trigger_in(button1);
  triggerable_enable_trigger(button1);
  GPIOINTRWrapper( );
}
