#!/bin/bash

if [ $# -ne 1 ] 
then
	echo "Please enter only one argument"
	exit 1
else
	if [[ $1 =~  ^[a-zA-Z[:punct:]]+$ ]]
	then
		echo $1
    else
		echo "Invalid value, the argument cannot consist of numbers"
        	exit 1
	fi      
fi 

