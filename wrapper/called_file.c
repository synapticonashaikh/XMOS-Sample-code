//header that contains the std lib and extension
#include "header.h"

static char buffer [100];

//function definition
char * capital(char *c)
{   
    uint16_t len = strlen(c);
    uint16_t i = 0;
    while (len--) 
    { buffer[i]= toupper(c[i]); i++; }
    return buffer;
}


