#[link(name = "fft", kind = "static")]
extern "C" {
    fn main_fft(x_in: *mut i32, n: usize);
}

use rand::Rng;
use std::time::{SystemTime, UNIX_EPOCH};

fn main() {
    unsafe {
        let mut rng = rand::thread_rng();
        let n = 8;
        let mut x_in: Vec<i32> = Vec::with_capacity(n);
        for _i in 0..n {
            x_in.push(rng.gen_range(0..10));
        }
        main_fft(x_in.as_mut_ptr(), n);
        println!("Done");
    }
}
