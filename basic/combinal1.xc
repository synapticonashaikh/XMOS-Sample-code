

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
    interface upyInterface { void SendCommand(int cmd);};

    interface upycommand   { void CheckCommand(int cmd);};

/* ----------------------------------------------------------------------------
 *                           Fnction Definitions
 * ----------------------------------------------------------------------------
*/
[[combinable]]
void fnMicroPython_Service(server interface upyInterface upc)
{

  int flag = 0;

    while (SET) 
    {

        select 
        {
            case  upc.SendCommand(int cmd):
                  switch(cmd)
                  {
                    case 1: printf("Script is running!\n"); flag = 1; break;
                    case 2: printf("Script stop running!\n"); break;
                  }
            break ;
        }
        if (flag == 1)
        {

          
        }

    }
}


[[combinable]]
void fnMicroPython_Commands(client interface upyInterface upc, server interface upycommand sendata)
{
    while (SET) 
    {
        select 
        {
          case sendata.CheckCommand(int cmd):
               printf("Before Send command\n");
               upc.SendCommand(1);
               printf("After Send command\n"); 
          break;
        }
    }
}


[[distributable]]
void StartTheCode (client interface upycommand sendata)
{
  sendata.CheckCommand(1);
  while (1){select{}}
}


/* ----------------------------------------------------------------------------
 *                           important command
 * ----------------------------------------------------------------------------
*/
	//xcc -target=XCORE-200-EXPLORER file_location/hello.c -o output_location/helloworld.xe
	//xsim output_location/helloworld.xe
	//xrun --io output_location/helloworld.xe

/***********************************************************************
 * Function Name: main 
 * Arguments	: void
 * Return Type	: int
 * Details	    : main function, start of the code
 * *********************************************************************/
int main ( ) 
{

    interface upyInterface   upc;
    interface upycommand sendata;
    par 
    {

          on tile [TILE0].core[0]: fnMicroPython_Service  ( upc ) ;
          on tile [TILE0].core[0]: fnMicroPython_Commands ( upc , sendata ) ;
          
          on tile [TILE0].core[1]: StartTheCode(sendata);
    }

return RESET;
}


