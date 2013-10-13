#include <stdio.h>
#include <fftw3.h>

int main(){
    int x,y;
    x=2;
    y=x+2;
    printf("Testing x:%d \n",y);
    x=1;
    y=x <<1;

    printf("bitshift y:%d\n",y);

    return 0;

}

