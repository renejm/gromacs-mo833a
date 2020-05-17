#!/bin/bash

wget https://files.rcsb.org/view/6LVN.pdb

cat <<EOF >>./ions.mdp
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

# Criar a topologia do ambiente que irá ser simulado:
echo 15 | ../../build/bin/gmx pdb2gmx -f 6LVN.pdb -o 6LVN_processed.gro -water spce

# Definir a “caixa” no qual a molécula, os ions e a água irá estar:
../../build/bin/gmx editconf -f 6LVN_processed.gro -o 6LVN_newbox.gro -c -d 1.0 -bt cubic

# Adicionar o solvente (água) na caixa:
../../build/bin/gmx solvate -cp 6LVN_newbox.gro -cs spc216.gro -o 6LVN_solv.gro -p topol.top

# Adicionar os ions na caixa:
../../build/bin/gmx grompp -f ions.mdp -c 6LVN_solv.gro -p topol.top -o ions.tpr
echo 13 | ../../build/bin/gmx genion -s ions.tpr -o 6LVN_solv_ions.gro -p topol.top -pname NA -nname CL -neutral

# Gerar a simulação:
../../build/bin/gmx grompp -f ions.mdp -c 6LVN_solv_ions.gro -p topol.top -o em.tpr
