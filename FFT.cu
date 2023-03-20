#include <stdio.h>
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

/**
 * Host main routine
 */
extern  "C" {

  int main_fft (void) {
      printf("Malloc of 1024 elements\n");
      int elements = 1024;
      int *x_in = malloc(sizeof(int) * elements);
      std::complex<double> *x_out = malloc(sizeof(std::complex<double>) * elements);
      printf("Calling function\n");
      printf("Free\n");
      free(x_in);
      free(x_out);
      printf("Done\n");
      return 0;
  }

}
