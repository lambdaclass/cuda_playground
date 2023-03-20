#[link(name = "vector_add", kind = "static")]
extern "C" {
    fn main_fft();
}

fn main() {
    unsafe {
        main_fft();
    }
}
