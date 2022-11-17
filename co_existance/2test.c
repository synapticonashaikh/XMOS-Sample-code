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

//function definition
char * CFunction3(char *d)
{
    static char c[40] = "This is just for the test purpose!";
    for (int abc = 0 ; abc < 0x4FF ; abc++ );
    strcat(c,d);
    printf("in pointer return function!\n\r");

return c;
}

 __attribute__(( fptrgroup("G1") ))
void fun(int a)
{ printf("Value of a is %d\n", a); }

 __attribute__(( fptrgroup("X1") ))
void fun1(int a)
{ printf("Value of a is %d\n", a); }

typedef void(*fun_ptr)(int);

void CFunctionPointer(void)
{    

    __attribute__(( fptrgroup("G1") ))void (*fun_ptr1)(int) = &fun1;  
    __attribute__(( fptrgroup("G1") ))fun_ptr x;
    x = fun; 
    x(10);
    (*fun_ptr1)(20);
}



#endif //__ENDS_C_FUNCTIONALITY