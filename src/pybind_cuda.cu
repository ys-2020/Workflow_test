#include <pybind11/pybind11.h>
#include <torch/extension.h>
#include <torch/serialize/tensor.h>

#include "hashmap/hashmap_cuda.cuh"

PYBIND11_MODULE(TORCH_EXTENSION_NAME, m) {
  py::class_<hashtable>(m, "GPUHashTable")
        .def(py::init<const int>())
        .def(py::init<torch::Tensor, torch::Tensor>())
        .def("insert_vals", &hashtable::insert_vals)
        .def("lookup_vals", &hashtable::lookup_vals)
        .def("insert_coords", &hashtable::insert_coords)
        .def("lookup_coords", &hashtable::lookup_coords);
}
