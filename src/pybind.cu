#include <pybind11/pybind11.h>
#include <torch/extension.h>
#include <iostream>
#include <dlfcn.h>

namespace py = pybind11;

extern "C" {
float call_my_kernel() {
    // cudaSetDevice(0);

// A better way to ref? Relative reference can lead to errors when the python file test.py is moved.
    void* handle = dlopen("./src/my_lib.so", RTLD_LAZY);
    if (!handle) {
        throw std::runtime_error("[pybind.cu] Failed to load shared object file. Please check the path to *.so.");
    }
    // Get a pointer to the CUDA kernel
    typedef float (*my_kernel_func)();
    my_kernel_func my_kernel = reinterpret_cast<my_kernel_func>(dlsym(handle, "my_test"));
    if (!my_kernel) {
        throw std::runtime_error("[pybind.cu] Failed to get pointer to CUDA kernel.");
    }

    float a = my_kernel();

    dlclose(handle);
    // cudaDeviceReset();
    return a;
}
}
// Define the PyBind11 module
PYBIND11_MODULE(TORCH_EXTENSION_NAME, m) {
    m.def("call_my_kernel", &call_my_kernel, "Call the CUDA kernel in mylib.so");
}
