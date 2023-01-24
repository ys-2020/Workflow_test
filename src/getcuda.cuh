#include <torch/extension.h>
#include<iostream>
#include<cuda.h>
#include<cuda_runtime.h>
using namespace std;

class GetGPUInfo {
 private:
  int nothing;
 public:
  GetGPUInfo(){
    // do nothing (default)
  };
  ~GetGPUInfo() {
    // do nothing (default)
  };
  int get_cuda(){
    int dev = 0;
    cudaDeviceProp devProp;
    cudaGetDeviceProperties(&devProp, dev);
    cout << "GPU device " << dev << ": " << devProp.name << endl;
    cout << "Number of SM:" << devProp.multiProcessorCount << endl;
    cout << "max_threads_per_block:" << devProp.maxThreadsPerBlock << endl;
    cout << "max_shared_memory_per_block:" << devProp.sharedMemPerBlock << " Bytes" << endl;
    return 0;
  };
};
