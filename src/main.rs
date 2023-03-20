#[link(name = "fft", kind = "static")]
extern "C" {
    fn main_fft();
}

fn main() {
    unsafe {
        main_fft();
    }
}
