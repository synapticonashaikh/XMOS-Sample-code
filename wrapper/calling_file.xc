
//header files
#include <platform.h>
#include <xs1.h>
#include <timer.h>
#include <print.h>	
# include <safestring.h> 
#include <safe/string.h>
//header that contains the std lib and extension
#include "header.h"


extern "C"{  char * capital(char *c);}


void task1 (chanend c, chanend d) 
{
    unsafe 
    {
    char * unsafe text = "this is just for the test";
    char * unsafe ret;

        c <: text;        
    
        select 
        {
            case d :> ret:
            printf("ret value = %s\n",ret);
            break ;
            //default: break;
        }     
    }
}

void task2 (chanend c, chanend d)
{
    unsafe 
    {    
    char * unsafe ret;
    char * unsafe text;    
        select 
        {
            case c :> text:
            printf("received value = %s\n",text);
            ret = capital(text);
            d <: ret;   
            break ;
            //default: break;
        }         
    }
}




//main function
int main( )
{


       // ret = capital(text,25) ;    
       // printf(ret);
       // printf("\n");
   
    chan c, d;
    par 
    {
        task1 ( c , d ) ;
        task2 ( c , d ) ;
    }

    return 0;
}
