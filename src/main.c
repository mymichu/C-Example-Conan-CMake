#include "utils/calculator.h"
#include <stdio.h>
int main(int argc, char *argv[])
{
    printf("------ VALUE ------\n");
    for(int i=0; i<10; i++){
        printf("Addition: %d\n",addition(i,15));
        int diffrence = subtraction(24,i);
        if(diffrence<5){
           printf("Difference: %d\n",diffrence);
        }
    }
    return 0;
}
