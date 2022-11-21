#include <stdio.h>


 
void fun(int a)
{ printf("Value of a is %d\n", a); }

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

int main (void)
{

    CFunctionPointer();


    return 0 ;
}