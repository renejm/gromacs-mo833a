#!/bin/bash

shopt -s extglob
if [ $(find ./ -type f | wc -l) -gt 3 ]; then
	echo "Limpando diretório..."
	rm !("runexp.sh"|"wipe.sh")
else
	echo "Diretório já está limpo!"
fi
