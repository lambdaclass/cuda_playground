use std::env;
use tempfile;

fn main() {
    let mut cfg = cc::Build::new();
    let tmp_dir = tempfile::TempDir::new().unwrap();
    let dst = tmp_dir.path().join("dst");
    cfg.cuda(true);
    cfg.include("project/include")
        .include("project/src")
        .file("project/src/HelloWorld.cu")
        .file("project/src/Validate.c")
        .out_dir(dst.join("lib"))
        .flag("-O2")
        .compile("libproject.a");

    println!("cargo:root={}", dst.display());
    println!("cargo:include={}", dst.join("include").display());
    println!(
        "cargo:rerun-if-changed={}",
        env::current_dir().unwrap().to_string_lossy()
    );
    println!("cargo:rerun-if-env-changed=PC_CC");

    if let Ok(cuda_path) = env::var("CUDA_HOME") {
        println!("cargo:rustc-link-search=native={}/lib64", cuda_path);
    } else {
        println!("cargo:rustc-link-search=native=/usr/local/cuda/lib64");
    }
    println!("cargo:rustc-link-lib=dylib=cudart");
}