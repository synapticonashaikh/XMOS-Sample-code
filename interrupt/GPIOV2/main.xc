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
    This file contains the source code to get the gpio interrupt.
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
	/*Standard Header files*/
	#include "header.h"	
    #include <hwtimer.h>    

/* ----------------------------------------------------------------------------
 *                           External Function
 * ----------------------------------------------------------------------------
*/  
    extern void FnGPIOInterruptInit (port Var); 
    extern void FnGPIOInterruptStart(port Var,uint8_t status);    
    extern void FnGPIOInterruptStop (port Var);  
    extern void FnGPIOInterruptManage(port Var);

/* ----------------------------------------------------------------------------
 *                           Global Variable
 * ----------------------------------------------------------------------------
*/ 
    port varGPIOInterrupt = XS1_PORT_1P;
    uint8_t TimerInterruptFlag = RESET;
/* ----------------------------------------------------------------------------
 *                           Function Definition
 * ----------------------------------------------------------------------------
*/ 
/***********************************************************************
 * Function Name: FnGPIOInterruptHandler 
 * Arguments	: void
 * Return Type	: void
 * Details	    : 
 * *********************************************************************/
void FnGPIOInterruptHandler(void)
{
    /*inside the callback it is important to have manage function
      So that it can manipulate the interrupt to rising/ falling edge only*/  
    //FnGPIOInterruptManage(varGPIOInterrupt);  
   TimerInterruptFlag = SET;
   printstr("");
}   
/***********************************************************************
 * Function Name: FnGPIOInterruptHandler 
 * Arguments	: void
 * Return Type	: void
 * Details	    : 
 * *********************************************************************/
void FnTimerProcess(void)
{

        if ( TimerInterruptFlag == SET )
        {    TimerInterruptFlag = RESET;
             printf("Timer Process!\n\r");
             //FnGPIOInterruptStop(varGPIOInterrupt);

        }
}




/***********************************************************************
 * Function Name: main 
 * Arguments	: void
 * Return Type	: int
 * Details	    : main function, start of the code
 * *********************************************************************/
void FnInfiniteLoop(void)
{
    timer    stTime;
    uint64_t uiTimeTotal; uint32_t uiCount=0; 
    
    stTime :> uiTimeTotal;
    uiTimeTotal = uiTimeTotal + ui1Sec ;   
    while(SET)
    {    
        stTime when timerafter(uiTimeTotal):> void;    
        uiTimeTotal = uiTimeTotal + ui1mSec ; uiCount++;
        //printf("S=%u\n\r",uiCount);                   

        FnTimerProcess( );
    }
}



/* ----------------------------------------------------------------------------
 *                           Start of the code
 * ----------------------------------------------------------------------------
*/ 
/***********************************************************************
 * Function Name: main 
 * Arguments	: void
 * Return Type	: int
 * Details	    : main function, start of the code
 * *********************************************************************/
int main( )
{
    /*start should come before init (to update the time)*/   
    FnGPIOInterruptStart(varGPIOInterrupt,irqGPIO_RISING_EDGE);    
    FnGPIOInterruptInit (varGPIOInterrupt);     
    FnInfiniteLoop( );
    return RESET;
}
