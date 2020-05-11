#!/bin/bash

echo " "
echo -e "\e[92m\e[1m********************************************************"
echo -e "************** INICIANDO O EXPERIMENTO... **************"
echo -e "********************************************************\e[0m"
echo " "

../../build/bin/gmx mdrun -nt 1 -v -deffnm em >> paramount-iteration-results-01thread.csv
../../build/bin/gmx mdrun -nt 4 -v -deffnm em >> paramount-iteration-results-04thread.csv
../../build/bin/gmx mdrun -nt 8 -v -deffnm em >> paramount-iteration-results-08thread.csv
../../build/bin/gmx mdrun -nt 16 -v -deffnm em >> paramount-iteration-results-16thread.csv

echo " "
echo -e "\e[92m\e[1m********************************************************"
echo -e "********** EXPERIMENTO EXECUTADO COM SUCESSO! **********"
echo -e "********************************************************\e[0m"
echo " "
