#!/bin/bash

shopt -s extglob
if [ $(find ./ -type f | wc -l) -gt 3 ]; then
	echo "Limpando diretório..."
	rm !("README.md"|"runexp.sh"|"build-gromacs.sh"|"config-gromacs.sh"|"wipe.sh"|"images"|"clap")
else
	echo "Diretório já está limpo!"
fi
