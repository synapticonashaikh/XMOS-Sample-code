#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>


int main (void)
{
    char tempdata [3200];    
    FILE *fp = fopen("test.txt","r");    
    fseek(fp,0,SEEK_END);
    int size = ftell(fp) - 3000;
    printf("size = %d\n\r",size);        
    fseek( fp, 3000, SEEK_SET );
    fread(tempdata, size, 1, fp ); 
    printf("data %s\n",tempdata);
    fclose(fp);
    fp = fopen("test.txt","w");        
    fputs( tempdata,fp );
    fclose(fp);
    return 0;
}