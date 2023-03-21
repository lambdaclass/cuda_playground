#[link(name = "fft", kind = "static")]
extern "C" {
    fn main_fft(elements: i32);
}

fn main() {
    unsafe {
        main_fft(8);
    }
}
