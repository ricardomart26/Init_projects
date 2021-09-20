#!bin/bash

file_name= 'dirname $0'
echo $file_name
NUMBER_ARGS=1

if [[ $# -lt NUMBER_ARGS ]]; then
	echo "Usage [sh $file_name Project_to_create]"
	exit 1
fi

if [ -e ~/Desktop/$1 ]; then
	read -p 'You want to delete everything inside the file? [y]/[n]' answer
fi

mkdir -p ~/Desktop/$1
mkdir -p ~/Desktop/$1/src ~/Desktop/$1/Objs ~/Desktop/$1/includes ~/Desktop/$1/tests

cp ~/Desktop/init_projects/Default_files/main.c ~/Desktop/$1/src/
cp ~/Desktop/init_projects/Default_files/utils.c ~/Desktop/$1/src/

touch ~/Desktop/$1/includes/$1.h

Project_name=$1
# name=($(tr [:lower:] [:upper:] ${Project_name}))
echo ${Project_name} | tr [:lower:] [:upper:] 

echo "#ifnedef $Project_name _H" | tr [:lower:] [:upper:] > ~/Desktop/$1/includes/$1.h
echo "#define $Project_name _H" >> ~/Desktop/$1/includes/$1.h
echo "" >> ~/Desktop/$1/includes/$1.h
echo "#include <unistd.h>" >> ~/Desktop/$1/includes/$1.h
echo "#include <stdio.h>" >> ~/Desktop/$1/includes/$1.h
echo "#include <stdlib.h>" >> ~/Desktop/$1/includes/$1.h
echo "#include <stdbool.h>" >> ~/Desktop/$1/includes/$1.h
echo "#include <fcntl.h>" >> ~/Desktop/$1/includes/$1.h
echo "" >> ~/Desktop/$1/includes/$1.h
echo "#endif" >> ~/Desktop/$1/includes/$1.h


cp ~/Desktop/init_projects/Default_files/Makefile ~/Desktop/$1 

Libft_dir=($(find ~/Desktop -maxdepth 1 -type d -iname "libft"))

echo "dir do libft $Libft_dir"

if ! [[ -e $Libft_dir ]]; then
	git submodule add git@github.com:ricardomart26/Libft.git ~/Desktop/$1 
else
	cp -rf $Libft_dir ~/Desktop/$1
fi
