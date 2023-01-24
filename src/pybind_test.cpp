#include <iostream>
#include <pybind11/pybind11.h>
#include <torch/extension.h>
#include <vector>
#include "getcuda.h"

PYBIND11_MODULE(TORCH_EXTENSION_NAME, m) {
  m.def("get_cuda",&get_cuda," ");
}
