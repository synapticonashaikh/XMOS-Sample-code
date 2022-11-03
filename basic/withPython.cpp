
/* ----------------------------------------------------------------------------
 *                           Includes
 * ----------------------------------------------------------------------------
*/

    /*XMOS related headers*/
    #include <platform.h>
    #include <xs1.h>
    #include <timer.h>
    #include <flash.h>
    #include <print.h>	    

    /*standard errors*/
    #include <stdio.h>
    #include <stdlib.h>
    #include <stdint.h>   
    #include <string.h>	                

    /*python header*/
      #include "/usr/include/python3.10/Python.h"


/***********************************************************************
 * Function Name: main 
 * Arguments	: void
 * Return Type	: int
 * Details	    : main function, start of the code
 * *********************************************************************/
int main ( ) 
{

  /*Standard printf function from stdio library*/
  	printf ("Hello World \n ") ;
  /*print function from print library*/
    printstrln("Hello World");  
	return RESET;
}
