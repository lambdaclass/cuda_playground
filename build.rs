extern crate cc;

fn main() {
    cc::Build::new()
        .cuda(true)
        .flag("-cudart=shared")
        .flag("-gencode")
        .flag("arch=compute_75,code=sm_75")
        .file("FFT.cu")
        .compile("libfft.a");

    println!("cargo:rustc-link-search=native=/usr/local/cuda/lib64");
    println!("cargo:rustc-link-lib=cudart");
}
