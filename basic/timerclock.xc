
/**************************************************************************************
 **************************************************************************************
 ______________________________________________________________________________________

  Company:
	Synapticon GmbH (https://www.synapticon.com/)
 ______________________________________________________________________________________

  File Name:
	ledwithtimer.xc
 ______________________________________________________________________________________

  Summary:
    This file contains the source code for testing all IO ports along with timer of XMOS.
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

     //structure variable
     TIMER0  Timerv;

/* ----------------------------------------------------------------------------
 *                           Fnction Definitions
 * ----------------------------------------------------------------------------
*/

/***********************************************************************
 * Function Name : main 
 * Arguments	  : void
 * Return Type	  : int
 * Details       : main function, start of the code
 * *********************************************************************/
void Function1 (void)
{

 /*set the timer for 1ms */
    Timerv.stTime :> Timerv.uiCompareTime;
    Timerv.uiCompareTime = Timerv.uiCompareTime + ui1mSec; 

    printf("Current=%d\tCompare=%d\n\r",
    Timerv.stTime, Timerv.uiCompareTime); 

    while(SET)
    {             
            Timerv.stTime when timerafter(Timerv.uiCompareTime) :> void; 
            Timerv.uiCompareTime += ui1mSec;
            Timerv.uiTime1mSec++;
            Timerv.TimerFlag.uiTime1mSecFlag = SET ;             
          
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
        {    Timerv.uiTime100mSec  = RESET ;
             Timerv.uiTime1Sec++;
             Timerv.TimerFlag.uiTime1SecFlag  = SET ;
        }       
        if ( Timerv.uiTime1Sec  >= (uint8_t)60 )
        {    Timerv.uiTime1Sec  = RESET ;
             Timerv.uiTime1Min++;
             Timerv.TimerFlag.uiTime1MinFlag  = SET ;      
        }           
        if ( Timerv.uiTime1Min  >= (uint8_t)60 )
        {    Timerv.uiTime1Min  = RESET ;
             Timerv.uiTime1Hour++;
             Timerv.TimerFlag.uiTime1HourFlag  = SET ;                      
        }                   
        if ( Timerv.uiTime1Hour  >= (uint8_t)24 )
        {   
            Timerv.uiTime1mSec   = 
            Timerv.uiTime100mSec = 
            Timerv.uiTime1Sec    = 
            Timerv.uiTime1Min    =  
            Timerv.uiTime1Hour   = RESET ;            
        }           
     if ( Timerv.TimerFlag.uiTime1SecFlag == SET   )
        { Timerv.TimerFlag.uiTime1SecFlag  = RESET ;
          printf("T-%u.%u.%u \n",Timerv.uiTime1Hour, Timerv.uiTime1Min ,Timerv.uiTime1Sec );  }      
    }

}

/***********************************************************************
 * Function Name : main 
 * Arguments	  : void
 * Return Type	  : int
 * Details       : main function, start of the code
 * *********************************************************************/
void Function2(void)
{
     while(SET)
     {

     
     }
}


/* ----------------------------------------------------------------------------
 *                           important command
 * ----------------------------------------------------------------------------
*/

	//xcc -target=XCORE-200-EXPLORER file_location/ledwithtimer.xc -o output_location/ledtimer.xe
	//xsim output_location/ledtimer.xe
	//xrun --io output_location/ledtimer.xe 


/***********************************************************************
 * Function Name : main 
 * Arguments	  : void
 * Return Type	  : int
 * Details       : main function, start of the code
 * *********************************************************************/
int main( )
{

   par 
    {
        on  tile[(uint8_t)0]: Function1();
        on  tile[(uint8_t)1]: Function2();
    }
    
return RESET;
}
