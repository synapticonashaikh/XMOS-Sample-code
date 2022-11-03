
/**************************************************************************************
 **************************************************************************************
 ______________________________________________________________________________________

  Company:
	Synapticon GmbH (https://www.synapticon.com/)
 ______________________________________________________________________________________

  File Name:
	hello.xc
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
 *                           MACROS
 * ----------------------------------------------------------------------------
*/


/* ----------------------------------------------------------------------------
 *                           Includes
 * ----------------------------------------------------------------------------
*/

	/*Standard Header files*/
	#include "header.h"
        

/* ----------------------------------------------------------------------------
 *                          GLOBAL VARIABLE DECLARATION
 * ----------------------------------------------------------------------------
*/

   interface TimerInterface {  void FlagStatus(TIMER0 &Timerv);  };


/* ----------------------------------------------------------------------------
 *                           Fnction Definitions
 * ----------------------------------------------------------------------------
*/

void task1(client interface TimerInterface i)
{

    /*taking the timer variable*/
    TIMER0 Timerv;

    Timerv.uiCompareTime;
		Timerv.TimerFlag.uiTime1mSecFlag  =
    Timerv.TimerFlag.uiTime10mSecFlag =
    Timerv.TimerFlag.uiTime100mSecFlag=
    Timerv.TimerFlag.uiTime1SecFlag   =
    Timerv.TimerFlag.uiTime1MinFlag   =
    Timerv.TimerFlag.uiTime1HourFlag  = RESET ;   

		Timerv.uiTime1uSec   =     
		Timerv.uiTime10uSec  =     
		Timerv.uiTime100uSec =     
		Timerv.uiTime1mSec   =
		Timerv.uiTime10mSec  =		
		Timerv.uiTime100mSec =    
		Timerv.uiTime1Sec    =
		Timerv.uiTime1Min    =
		Timerv.uiTime1Hour   = RESET ;


    /*extracting the current time count*/
    Timerv.stTime :> Timerv.uiCompareTime;

    while (SET)
    {
      /*add compare time*/
      Timerv.uiCompareTime = Timerv.uiCompareTime + ui1mSec;
      /*wait until the time is over*/
      Timerv.stTime when timerafter(Timerv.uiCompareTime) :> void;
      /*call the main function */
      i.FlagStatus(Timerv) ;
    }

}

void task2(server interface TimerInterface i)
{
    while (SET)
    {
        select 
        {
            case i.FlagStatus(TIMER0 &Timerv):
            { 
                   Timerv.TimerFlag.uiTime1mSecFlag = SET ;
                   Timerv.uiTime1mSec++;
               if( Timerv.uiTime1mSec >= (uint8_t)10)  
                 { Timerv.uiTime1mSec  = RESET ;
                   Timerv.uiTime10mSec++;
                   Timerv.TimerFlag.uiTime10mSecFlag = SET ;       
                 }
              if( Timerv.uiTime10mSec >= (uint8_t)10 )
                { Timerv.uiTime10mSec  = RESET ;
                  Timerv.uiTime100mSec++;
                  Timerv.TimerFlag.uiTime100mSecFlag = SET ;
                }
              if ( Timerv.uiTime100mSec >= (uint8_t)10 )
                 { Timerv.uiTime100mSec  = RESET ;
                   Timerv.uiTime1Sec++;
                   Timerv.TimerFlag.uiTime1SecFlag = SET ;
                 }
              if ( Timerv.uiTime1Sec  >= (uint8_t)60 )
                {  Timerv.uiTime1Sec  = RESET ;
                   Timerv.uiTime1Min++;
                   Timerv.TimerFlag.uiTime1MinFlag  = SET ;      
                }           
              if ( Timerv.uiTime1Min  >= (uint8_t)60 )
                {  Timerv.uiTime1Min  = RESET ;
                   Timerv.uiTime1Hour++;
                   Timerv.TimerFlag.uiTime1HourFlag  = SET ;                      
                }                   
             
                if ( Timerv.TimerFlag.uiTime1SecFlag == SET )
                   { Timerv.TimerFlag.uiTime1SecFlag = RESET ;
                     printf("T-%d.%d.%d \n",
                     Timerv.uiTime1Hour, Timerv.uiTime1Min, Timerv.uiTime1Sec );  
                   }    
            } break ;

            default: break; // to make the select non-blockable 
        }      
    }
}


/* ----------------------------------------------------------------------------
 *                           important command
 * ----------------------------------------------------------------------------
*/
	//xcc -target=XCORE-200-EXPLORER file_location/interface.c -o output_location/interface.xe
	//xsim output_location/interface.xe
	//xrun --io output_location/interface.xe


/***********************************************************************
 * Function Name: main 
 * Arguments	: void
 * Return Type	: int
 * Details	    : main function, start of the code
 * *********************************************************************/
int main ( void )
{

    interface TimerInterface i;
    par 
    {
        task1 ( i ) ;
        task2 ( i ) ;
    }

return RESET ;
}