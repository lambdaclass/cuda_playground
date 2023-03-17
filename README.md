# CUDA playground in Rust
Made for learning how to parallelize computations in the GPU using CUDA, in Rust, via the [cc](https://crates.io/crates/cc) crate.

## Overview
The source code will contain documented examples of use, growing in complexity, aimed at a final objective of parallelize a Fast Fourier Transform algorithm.

## Pre-requisites

- [Rust](https://www.rust-lang.org/es/tools/install)
- [CUDA](https://developer.nvidia.com/cuda-downloads)

## References
- [NVIDIA CUDA-Samples](https://github.com/NVIDIA/cuda-samples) An NVIDIA repository with a lot of CUDA examples. It can be useful to run deviceQuery and get informatio about our GPU capabilites
- [HowTo: Compile CUDA with nvcc, and link to Rust through FFI](https://github.com/termoshtt/link_cuda_kernel): It is an example repository which can be useful to start using CUDA and rust together. Use it to check if your GPU is correctly configured.
