#[link(name = "fft", kind = "static")]
extern "C" {
    fn fft();
}

fn main() {
    unsafe {
        main_fft();
    }
}
