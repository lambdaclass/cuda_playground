use rand::prelude::*;
use std::slice;

#[link(name = "ntt", kind = "static")]
extern "C" {
    fn main_ntt(x_in: *mut i32, x_out: *mut i32, n: usize);
}


fn main() {
    unsafe {
        let mut rng = rand::thread_rng();
        let n = 8;
        let mut x_in: Vec<i32> = Vec::with_capacity(n);
        let mut x_out: Vec<i32> = Vec::with_capacity(n);
        for _i in 0..n {
            x_in.push(rng.gen_range(0..10));
        }
        println!("X_in: {:?}", x_in);
        let ptr_out = x_out.as_mut_ptr();
        let ptr_in = x_in.as_mut_ptr();

        main_ntt(ptr_in, ptr_out, n);

        let slice = slice::from_raw_parts(ptr_out, n);
        println!("slice {}", slice[0]);
        println!("X_out: {:?}", slice);
        println!("Done with Rust!");
    }
}
