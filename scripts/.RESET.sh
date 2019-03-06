#!/bin/bash

n=10

if [ "$#" -gt 0 ]
   then n=$1
fi 

for((i=0; i<$n; i++))
    do printf "\e[48;5;196m RESET\n"
done
printf '\e[0m\n' 
