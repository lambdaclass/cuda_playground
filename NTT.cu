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

__global__ void mykernel(void){

}

void ntt_rec(int *x, int N, int w, int mod) {
	if (N <= 1) {
		return;
	}

	int odd[N/2];
	int even[N/2];
	for (int i = 0; i < N / 2; i++) {
		even[i] = x[i*2];
		odd[i] = x[i*2+1];
	}

	ntt_rec(even, N/2, (1LL * w * w) % mod, mod);
	ntt_rec(odd, N/2, (1LL * w * w) % mod, mod);

	// Calculate NTT
	int wn = 1;
	for (int k = 0; k < N / 2; k++) {
		int t = (1LL * wn * odd[k]) % mod;
		x[k] = (even[k] + t) % mod;
		x[N / 2 + k] = (even[k] - t + mod) % mod;
		wn = (1LL * wn * w) % mod;
	}
}

void ntt(int *x_in, int *x_out, int N) {
	const int mod = 998244353;
	const int w = 3;

	// Make copy of array and apply window
	for (int i = 0; i < N; i++) {
		x_out[i] = x_in[i];
		x_out[i] *= 1; // Window
	}

	ntt_rec(x_out, N, w, mod);
}

/**
 * Host main routine
 */
extern  "C" {

  void main_ntt (int *x_in, int n) {
      printf("Malloc of %d elements\n", n);
      int *x_out = (int*)malloc(sizeof(int) * n);

      for(int i = 0; i < n; i++){
        printf("%d\n", x_in[i]);
      }

      printf("Calling function\n");
      ntt(x_in, x_out, n);

      for(int i = 0; i < n; i++){
        int elem = x_out[i];
        printf("%d\n", elem);
      }

      printf("Free\n");
      free(x_out);
  }

}