#include <iostream>
#include <cuda.h>
#include <cuda_runtime.h>

void random_init(float *data, size_t size) {
    for (size_t i = 0; i < size; ++i) {
        data[i] = float(rand()) / RAND_MAX;
    }
}


__global__ void add_kernel(float* a, float* b, float* c, int n) {
    int idx = threadIdx.x + blockIdx.x * blockDim.x;
    if (idx < n) {
        c[idx] = a[idx] + b[idx];
    }
}


extern "C"{
    float my_test() {
        
        int n = 4096;

        float *h_A, *h_B, *h_C;
        cudaMallocHost(&h_A, n * sizeof(float));
        cudaMallocHost(&h_B, n * sizeof(float));
        cudaMallocHost(&h_C, n * sizeof(float));
        random_init(h_A, n);
        random_init(h_B, n);

        float *d_A, *d_B, *d_C;
        cudaMalloc(&d_A, n * sizeof(float));
        cudaMalloc(&d_B, n * sizeof(float));
        cudaMalloc(&d_C, n * sizeof(float));

        cudaMemcpy(d_A, h_A, n * sizeof(float), cudaMemcpyDefault);
        cudaMemcpy(d_B, h_B, n * sizeof(float), cudaMemcpyDefault);

        cudaEvent_t start, end;
        cudaEventCreate(&start);
        cudaEventCreate(&end);

        cudaEventRecord(start);
        add_kernel<<<((n + 255) / 256), 256>>>(d_A, d_B, d_C, n);
        cudaEventRecord(end);
        cudaEventSynchronize(end);

        cudaMemcpy(h_C, d_C, n * sizeof(float), cudaMemcpyDefault);

        printf("%f\n",h_C[0]);
        float ret = h_C[0];

        cudaFree(d_A);
        cudaFree(d_B);
        cudaFree(d_C);
        cudaFreeHost(h_A);
        cudaFreeHost(h_B);
        cudaFreeHost(h_C);
        return ret;
    }
}