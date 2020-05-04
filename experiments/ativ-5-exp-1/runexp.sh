#!/bin/bash

echo " "
echo -e "\e[92m\e[1m********************************************************"
echo -e "************** INICIANDO O EXPERIMENTO... **************"
echo -e "********************************************************\e[0m"
echo " "

time mpirun -n 4 --hostfile ~/hostfile ../../build/bin/gmx_mpi mdrun -v -deffnm em > ~/experiment-log.txt

echo " "
echo -e "\e[92m\e[1m********************************************************"
echo -e "********** EXPERIMENTO EXECUTADO COM SUCESSO! **********"
echo -e "********************************************************\e[0m"
echo " "
