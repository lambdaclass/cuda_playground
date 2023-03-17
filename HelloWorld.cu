#include "HelloWorld.h"


__global__ void mykernel(void){

}

extern  "C" {
void cudaTest(){
    mykernel<<<1,1>>>();
    printf("Hello World!\n");
}
}
