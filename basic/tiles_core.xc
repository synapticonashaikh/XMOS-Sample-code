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
    int a;

/* ----------------------------------------------------------------------------
 *                           Fnction Definitions
 * ----------------------------------------------------------------------------
*/

/***********************************************************************
 * Function Name: FnTask1, FnTask2, FnTask3, FnTask4
 * Arguments	: void
 * Return Type	: void
 * Details	    : print the task number
 * *********************************************************************/
void FnTask1(void)
{
  a = 3 ;
    while (SET)
    { 
      delay_milliseconds(1000) ; //this function does not work in simulation 
      printf("Currently on task1\n\r"); }
}

void FnTask2(void)
{
    while (SET)
    {  delay_milliseconds(1000) ; //this function does not work in simulation
       printf("Currently on task2\n\r"); }
}

void FnTask3(void)
{
  
    while (SET)
    {  delay_milliseconds(1000) ; //this function does not work in simulation
       printf("Currently on task3\n\r"); }
}

void FnTask4(void)
{
    while (SET)
    {  delay_milliseconds(1000) ; //this function does not work in simulation
       printf("Currently on task4\n\r"); }
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
      par 
    {
         /*function FnTask1 can't be called twice 
         because it is using a global variable*/
         //assigning funcnction to tiles (tile 0)
         on  tile[TILE0]: FnTask1();
         on  tile[TILE0]: FnTask2();
         on  tile[TILE0]: FnTask3();
         on  tile[TILE0]: FnTask4();
         on  tile[TILE0]: FnTask2();
         on  tile[TILE0]: FnTask3();
         on  tile[TILE0]: FnTask4();
         on  tile[TILE0]: FnTask2();

         //assigning funcnction to tiles (tile 1)
         on  tile[TILE1]: FnTask3();
         on  tile[TILE1]: FnTask4();
         on  tile[TILE1]: FnTask3();
         on  tile[TILE1]: FnTask2();                  
         on  tile[TILE1]: FnTask2();
         on  tile[TILE1]: FnTask3();
         on  tile[TILE1]: FnTask4();
         on  tile[TILE1]: FnTask2();

    }

  return RESET;
}