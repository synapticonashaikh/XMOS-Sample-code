//includes
#include "xcHeader.h"

//Start of the code
int main ( )
{

    par //parallel processing
    {  
      //parallel processing of C and C++ function is not possible  
      #if (__ENDS_C_FUNCTIONALITY == SET)
            CFunction1();
            CFunction2(); 
      #endif
    }

    par
    {
      //parallel processing of C++ function is not possible
      #if(__ENDS_CPP_FUNCTIONALITY == SET) 
            CPPFunction1();
            //CPPFunction2();                   
      #endif         
    }                       

return 0;
}