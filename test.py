import torch
import workflowtest

if __name__ == "__main__":
    gpuinfo = workflowtest.GetGPUInfo()
    gpuinfo.get_cuda()