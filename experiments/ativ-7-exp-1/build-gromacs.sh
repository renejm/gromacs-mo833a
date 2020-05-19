#!/bin/bash

echo "Iniciando experimento..." > /home/ubuntu/log_atividade7.txt

sudo apt-get update 2>> /home/ubuntu/log_atividade7.txt
sudo apt-get install -y wget make gcc libgfortran3 sysstat libibnetdisc-dev openmpi-bin libopenmpi-dev libhdf5-openmpi-dev gfortran build-essential git 2>> /home/ubuntu/log_atividade7.txt

echo "Pacotes instalados!" >> /home/ubuntu/log_atividade7.txt

wget https://github.com/Kitware/CMake/releases/download/v3.17.2/cmake-3.17.2-Linux-x86_64.sh 2>> /home/ubuntu/log_atividade7.txt
chmod +x cmake-3.17.2-Linux-x86_64.sh
bash cmake-3.17.2-Linux-x86_64.sh --skip-license
sudo ln -s /home/ubuntu/bin/* /usr/local/bin
echo "CMake instalado!" >> /home/ubuntu/log_atividade7.txt

git clone --single-branch --branch ativ-7-exp-1 https://github.com/renejm/gromacs-mo833a.git 2>> /home/ubuntu/log_atividade7.txt
echo "Fonte do GROMACS baixada!" >> /home/ubuntu/log_atividade7.txt

cd gromacs-mo833a/
mkdir build
cd build
echo "Diretório build criado!" >> /home/ubuntu/log_atividade7.txt

echo "INICIANDO CMAKE..." >> /home/ubuntu/log_atividade7.txt
cmake .. -DGMX_BUILD_OWN_FFTW=ON -DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpicxx -DGMX_MPI=on 1> /home/ubuntu/cmake.out 2> /home/ubuntu/cmake.err
echo "CMake executado!" >> /home/ubuntu/log_atividade7.txt

echo "INICIANDO COMPILAÇÃO!" >> /home/ubuntu/log_atividade7.txt
make -j3 1> /home/ubuntu/compilation.out 2> /home/ubuntu/compilation.err

echo "Compilação concluída!" >> /home/ubuntu/log_atividade7.txt
