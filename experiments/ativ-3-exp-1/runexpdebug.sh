#!/bin/bash

[[ -f ./6LVN.pdb ]] && echo "$FILE já existe!" || wget https://files.rcsb.org/view/6LVN.pdb

FILE=./ions.mdp
if [[ -f "$FILE" ]]; then
    echo "$FILE já existe!"
else
	cat <<EOF >>$FILE
integrator  = steep     	; Algorithm (steep = steepest descent minimization)
emtol   	= 1000.0    	; Stop minimization when the maximum force < 1000.0 kJ/mol/nm
emstep  	= 0.01      	; Minimization step size
nsteps  	= 50000     	; Maximum number of (minimization) steps to perform

; Parameters describing how to find the neighbors of each atom and how to calculate the interactions
nstlist     	= 1     	; Frequency to update the neighbor list and long range forces
cutoff-scheme    = Verlet	; Buffered neighbor searching
ns_type     	= grid  	; Method to determine neighbor list (simple, grid)
coulombtype 	= cutoff	; Treatment of long range electrostatic interactions
rcoulomb    	= 1.0   	; Short-range electrostatic cut-off
rvdw        	= 1.0   	; Short-range Van der Waals cut-off
pbc         	= xyz   	; Periodic Boundary Conditions in all 3 dimensions
EOF
fi

# Limpar o diretório:
shopt -s extglob
if [ $(find ./ -type f | wc -l) -gt 7 ]; then
	echo "Limpando diretório..."
	rm !("runexp.sh"|"runexpdebug.sh"|"wipe.sh"|"ions.mdp"|"6LVN.pdb"|"execution_time_samples.csv"|"execution_time_samples_debug.csv")
else
	echo "Diretório já está limpo!"
fi

# Criar a topologia do ambiente que irá ser simulado:
echo 15 | ../../build-debug/bin/gmx pdb2gmx -f 6LVN.pdb -o 6LVN_processed.gro -water spce

# Definir a “caixa” no qual a molécula, os ions e a água irá estar:
../../build-debug/bin/gmx editconf -f 6LVN_processed.gro -o 6LVN_newbox.gro -c -d 1.0 -bt cubic

# Adicionar o solvente (água) na caixa:
../../build-debug/bin/gmx solvate -cp 6LVN_newbox.gro -cs spc216.gro -o 6LVN_solv.gro -p topol.top

# Adicionar os ions na caixa:
../../build-debug/bin/gmx grompp -f ions.mdp -c 6LVN_solv.gro -p topol.top -o ions.tpr
echo 13 | ../../build-debug/bin/gmx genion -s ions.tpr -o 6LVN_solv_ions.gro -p topol.top -pname NA -nname CL -neutral

# Gerar a simulação:
../../build-debug/bin/gmx grompp -f ions.mdp -c 6LVN_solv_ions.gro -p topol.top -o em.tpr

# Emitir alerta sonoro
for (( counter=0; counter<3; counter++ ))
do
	echo -ne "\007"
	sleep 0.2
done

echo "INICIANDO O EXPERIMENTO SOBRE A VERSÃO EM DEBUG MODE..."
sleep 3

# Executar experimento:
for i in `seq 1 101`; do
	echo " "
	echo -e "\e[92m\e[1m*****************************************************"
	echo -e "********** EXECUÇÃO NÚMERO $i (DEBUG MODE) **********"
	echo -e "*****************************************************\e[0m"
	echo " "
	../../build-debug/bin/gmx mdrun -v -deffnm em | grep MO833 >> execution_time_samples_debug.txt
done

echo " "
echo -e "\e[92m\e[1m********************************************************"
echo -e "********** EXPERIMENTO EXECUTADO COM SUCESSO! **********"
echo -e "********************************************************\e[0m"
echo " "

# Criar arquivo .csv
cut -d\  -f5 < execution_time_samples_debug.txt > execution_time_samples_debug.csv

rm -f execution_time_samples_debug.txt

# Emitir alerta sonoro
for (( counter=0; counter<10; counter++ ))
do
	echo -ne "\007"
	sleep 0.2
done
