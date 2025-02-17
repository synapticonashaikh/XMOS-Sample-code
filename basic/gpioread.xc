
/**************************************************************************************
 **************************************************************************************
 ______________________________________________________________________________________

  Company:
	Synapticon GmbH (https://www.synapticon.com/)
 ______________________________________________________________________________________

  File Name:
	led.xc
 ______________________________________________________________________________________

  Summary:
    This file contains the source code for testing all IO ports of XMOS.
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

    int count = RESET;
    int e,temp;
    port _Port1A  = PORT1A  ;
    port _Port1B  = PORT1B  ;
    port _Port1C  = PORT1C  ;
    port _Port1D  = PORT1D  ;
    port _Port1E  = PORT1E  ;
    port _Port1F  = PORT1F  ;
    port _Port1G  = PORT1G  ;
    port _Port1H  = PORT1H  ;
    port _Port1I  = PORT1I  ;
    port _Port1J  = PORT1J  ;
    port _Port1K  = PORT1K  ;
    port _Port1L  = PORT1L  ;
    port _Port1M  = PORT1M  ;
    port _Port1N  = PORT1N  ;
    port _Port1O  = PORT1O  ;
    port _Port1P  = PORT1P  ;

	/*IO ports-4BITS*/
    port _Port4A  = PORT4A  ;
    port _Port4B  = PORT4B  ;
    port _Port4C  = PORT4C  ;
    port _Port4D  = PORT4D  ;
    port _Port4E  = PORT4E  ;
    port _Port4F  = PORT4F  ;

	/*IO ports-8BITS*/
    port _Port8A  =  PORT8A  ;
    port _Port8B  =  PORT8B  ;
    port _Port8C  =  PORT8C  ;
    port _Port8D  =  PORT8D  ;

	/*IO ports-16BITS*/
    port _Port16A = PORT16A  ;
    port _Port16B = PORT16B  ;

	/*IO ports-32BITS*/
    port _Port32A = PORT32A  ;

/* ----------------------------------------------------------------------------
 *                           Fnction Definitions
 * ----------------------------------------------------------------------------
*/

/* ----------------------------------------------------------------------------
 *                           important command
 * ----------------------------------------------------------------------------
*/

	//xcc -target=XCORE-200-EXPLORER file_location/led.xc -o output_location/ledtoggle.xe
	//xsim output_location/ledtoggle.xe
	//xrun --io output_location/ledtoggle.xe 
  

/***********************************************************************
 * Function Name: main 
 * Arguments	: void
 * Return Type	: int
 * Details	    : main function, start of the code
 * *********************************************************************/
int main ( )
{

    while (SET)
    {
         count++;
        _Port4D @ e :> temp;
        printf("[%d]P1L = %2x \n\r",count,~(uint8_t)temp & 0x0F);        
        delay_milliseconds(500) ; //this function does not work in simulation       

    }

return RESET;
}