#!/bin/bash

cd ../..
mkdir -p build
cd build
cmake .. -DGMX_BUILD_OWN_FFTW=ON -DGMX_MPI=on -DREGRESSIONTEST_DOWNLOAD=ON -DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpicxx
make
