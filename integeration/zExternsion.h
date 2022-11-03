#ifndef __zExtension_h //to avoid multiple times' inclusion
#define __zExtension_h

    //includes
    #include "zDefinitions.h"  

     //function declairation
    #if (__ENDS_C_FUNCTIONALITY   ==  SET)
         extern "C" { extern int CFunction1(void); 
                      extern int CFunction2(void);  }
    #endif //__ENDS_C_FUNCTIONALITY  

    #if (__ENDS_CPP_FUNCTIONALITY   ==  SET)
        extern "C" { extern int CPPFunction1(void);
                     extern int CPPFunction2(void); }
    #endif //__ENDS_CPP_FUNCTIONALITY


#endif    