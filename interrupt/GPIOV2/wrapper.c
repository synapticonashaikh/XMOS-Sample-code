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
 *                           Includes
 * ----------------------------------------------------------------------------
*/
    #include "header.h"	
    #include "interrupt.h"    
    #include <hwtimer.h>  
    #include <xs1.h>
    #include <xcore/port.h>
    #include <print.h>	
/* ----------------------------------------------------------------------------
 *                           Macros
 * ----------------------------------------------------------------------------
*/
    register_interrupt_handler(FnGPIOInterruptHandler, 1, 200)    

/* ----------------------------------------------------------------------------
 *                           External Function
 * ----------------------------------------------------------------------------
*/  
    void FnGPIOInterruptHandler(void);

/* ----------------------------------------------------------------------------
 *                           Global Variable
 * ----------------------------------------------------------------------------
*/ 
  static uint8_t RisingFallingEdge;  //current code generates on rising edge!
  static uint8_t uifeedback,uiStatus;
  static uint8_t uiCurrentState;
/* ----------------------------------------------------------------------------
 *                           Function Definition
 * ----------------------------------------------------------------------------
*/
/***********************************************************************
 * Function Name: main 
 * Arguments	: void
 * Return Type	: int
 * Details	    : main function, start of the code
 * *********************************************************************/
void FnGPIOInterruptStop(port_t Var)
{
    DISABLE_INTERRUPTS( );
    asm volatile("setc res[%0], %1"::"r"(Var),"r"(XS1_SETC_COND_NONE));
}
/***********************************************************************
 * Function Name: main 
 * Arguments	  : void
 * Return Type	: int
 * Details	    : main function, start of the code
 * *********************************************************************/
void FnGPIOInterruptUpdate(port_t Var, uint8_t value)
{
    FnGPIOInterruptStop(Var);
    asm volatile("setd res[%0], %1"::"r"(Var),"r"(value));
    asm volatile("setc res[%0], %1"::"r"(Var),"r"(XS1_SETC_COND_EQ));
}    
/***********************************************************************
 * Function Name: main 
 * Arguments	: void
 * Return Type	: int
 * Details	    : main function, start of the code
 * *********************************************************************/
void FnGPIOInterruptInit(port_t Var)
{  set_interrupt_handler(FnGPIOInterruptHandler, 1, Var, 0);  }
/***********************************************************************
 * Function Name: main 
 * Arguments	: void
 * Return Type	: int
 * Details	    : main function, start of the code
 * *********************************************************************/
void FnGPIOInterruptStart(port_t Var,uint8_t status)
{
    RisingFallingEdge = status; 
    FnGPIOInterruptUpdate(Var,status);
}
/***********************************************************************
 * Function Name: main 
 * Arguments	  : void
 * Return Type	: int
 * Details	    : main function, start of the code
 * *********************************************************************/
void FnGPIOInterruptManage(port_t Var)
{
  //manipulation to get the interrupt on rising/falling edge only
  uifeedback = port_peek(Var); 
  FnGPIOInterruptUpdate(Var, uiCurrentState);
  uiCurrentState = !uiCurrentState;

  if (RisingFallingEdge == irqGPIO_RISING_EDGE)
  {  
    if   (( uifeedback == 1 ) && (uiStatus == 0)){ printf("~1\n"); FnGPIOInterruptHandler( ); uiStatus = 1;}
  else if ((uifeedback == 0 ) && (uiStatus == 1)){ uiStatus = 0;   }
  }
  else
  {
    if   (( uifeedback == 1 ) && (uiStatus == 0)){ uiStatus = 0;}
  else if ((uifeedback == 0 ) && (uiStatus == 1)){ printf("~2\n");FnGPIOInterruptHandler( );  uiStatus = 1;}
  }
}