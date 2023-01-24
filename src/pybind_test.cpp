#include <iostream>
#include <pybind11/pybind11.h>
#include <torch/extension.h>
#include <vector>
#include "getcuda.cuh"

PYBIND11_MODULE(TORCH_EXTENSION_NAME, m) {
  py::class_<GetGPUInfo>(m, "GetGPUInfo")
        .def(py::init<>())
        .def("get_cuda", &GetGPUInfo::get_cuda);
}


