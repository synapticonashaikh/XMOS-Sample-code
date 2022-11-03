//includes
#include "cHeader.h"

//hash definition
#if (__ENDS_C_FUNCTIONALITY == SET)

//function definition
int CFunction1(void)
{
    for (int abc = 0 ; abc < 0x4FF ; abc++ );
    printf("C function1 executing!\n\r");

return 0 ;
}

//function definition
int CFunction2(void)
{
    for (int abc = 0 ; abc < 0x4FF ; abc++ );
    printf("C function2 executing!\n\r");

return 0 ;
}

#endif //__ENDS_C_FUNCTIONALITY