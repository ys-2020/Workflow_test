from setuptools import find_packages, setup
from torch.utils.cpp_extension import BuildExtension, CUDAExtension, CppExtension

src = "src/"

extra_compile_args = {
    'cxx': ['-g', '-O3', '-fopenmp', '-lgomp'],
    'nvcc': ['-O3', '-std=c++17']
}

setup(
    name='workflow_test',
    packages=find_packages(),
    ext_modules=[
        CUDAExtension(name='workflowtest',
                      sources =
                      [src+'pybind_test.cpp'],
                      extra_compile_args=extra_compile_args),                
    ],
    cmdclass={
        'build_ext': BuildExtension
    },
    install_requires=['torch']
)

