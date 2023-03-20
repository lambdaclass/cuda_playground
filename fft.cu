#include "fft.h"


__global__ void mykernel(void){

}

extern  "C" {
void cudaTest(){
    mykernel<<<1,1>>>();
    
}
}
