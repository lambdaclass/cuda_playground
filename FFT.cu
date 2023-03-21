#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "cuda_runtime.h"

/* ---------------------------------------------------------------------------
** Basic implementation of Cooley-Tukey FFT algorithm in C++
**
** Author: Darko Lukic <lukicdarkoo@gmail.com>
** -------------------------------------------------------------------------*/

#include <cmath>
#include <complex>

__global__ void mykernel(void){

}

void fft_rec(std::complex<double> *x, int N) {
	// Check if it is splitted enough
	if (N <= 1) {
		return;
	}

	// Split even and odd
	std::complex<double> odd[N/2];
	std::complex<double> even[N/2];
	for (int i = 0; i < N / 2; i++) {
		even[i] = x[i*2];
		odd[i] = x[i*2+1];
	}

	// Split on tasks
	fft_rec(even, N/2);
	fft_rec(odd, N/2);


	// Calculate DFT
	for (int k = 0; k < N / 2; k++) {
		std::complex<double> t = exp(std::complex<double>(0, -2 * M_PI * k / N)) * odd[k];
		x[k] = even[k] + t;
		x[N / 2 + k] = even[k] - t;
	}
}

void fft(int *x_in,
	std::complex<double> *x_out,
	int N) {

	// Make copy of array and apply window
	for (int i = 0; i < N; i++) {
		x_out[i] = std::complex<double>(x_in[i], 0);
		x_out[i] *= 1; // Window
	}

	// Start recursion
	fft_rec(x_out, N);
}

/**
 * Host main routine
 */
extern  "C" {

  int main_fft (int elements) {
      srand(time(NULL));

      printf("Malloc of %d elements\n", elements);
      int *x_in = (int*)malloc(sizeof(int) * elements);
      std::complex<double> *x_out = (std::complex<double>*)malloc(sizeof(std::complex<double>) * elements);

      printf("Set random elements\n");
      for(int i = 0; i < elements; i++){
        x_in[i] = (rand() % 10);
      }

      for(int i = 0; i < elements; i++){
        printf("%d\n", x_in[i]);
      }

      printf("Calling function\n");
      fft(x_in, x_out, elements);

      for(int i = 0; i < elements; i++){
        std::complex<double> elem = x_out[i];
        printf("%f%+fi\n", std::real(elem), std::imag(elem));
      }

      printf("Free\n");
      free(x_in);
      free(x_out);

      printf("Done\n");
      return 0;
  }

}
