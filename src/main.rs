#[link(name = "vector_add", kind = "static")]
extern "C" {
    fn cudaTest();
}

fn main() {
    unsafe {
        cudaTest();
    }
}
