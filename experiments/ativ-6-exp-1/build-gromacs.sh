#!/bin/bash

cd ../..
mkdir -p build
cd build
cmake .. -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=ON -DCMAKE_BUILD_TYPE=Release
make -j16