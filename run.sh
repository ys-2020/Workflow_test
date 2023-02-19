cd src
nvcc -shared  mykernel.cu -o my_lib.so -Xcompiler -fPIC -lcuda -lcudart -lcublas -lcurand -lcudnn
cd ..
python setup.py install
python test.py
