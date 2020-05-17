#!/bin/bash

echo "Iniciando experimento..." > ~/log_ativ6.txt

sudo apt-get update 2>> ~/log_ativ6.txt
sudo apt-get install -y wget make gcc libgfortran3 sysstat libibnetdisc-dev openmpi-bin libopenmpi-dev libhdf5-openmpi-dev gfortran build-essential git 2>> ~/log_ativ6.txt

echo "Pacotes instalados!" >> ~/log_ativ6.txt

wget https://github.com/Kitware/CMake/releases/download/v3.17.2/cmake-3.17.2-Linux-x86_64.sh 2>> ~/log_ativ6.txt
chmod +x cmake-3.17.2-Linux-x86_64.sh
bash cmake-3.17.2-Linux-x86_64.sh --skip-license
sudo ln -s /home/ubuntu/bin/* /usr/local/bin
echo "CMake instalado!" >> ~/log_ativ6.txt

git clone --single-branch --branch ativ-7-exp-1 https://github.com/renejm/gromacs-mo833a.git 2>> ~/log_ativ6.txt
echo "Fonte do GROMACS baixada!" >> ~/log_ativ6.txt

cd gromacs-mo833a/
mkdir build
cd build
echo "Diretório build criado!" >> ~/log_ativ6.txt

echo "INICIANDO CMAKE..." >> ~/log_ativ6.txt
cmake .. -DGMX_BUILD_OWN_FFTW=ON -DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpicxx -DGMX_MPI=on 1> cmake.out 2> cmake.err
echo "CMake executado!" >> ~/log_ativ6.txt

echo "INICIANDO COMPILAÇÃO!" >> ~/log_ativ6.txt
make -i -j6 1> compilation.out 2> compilation.err

echo "Compilação concluída!" >> ~/log_ativ6.txt
