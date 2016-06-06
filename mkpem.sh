#!/bin/bash

e_missingarg=1
e_nofile=2
e_interrupted=3

function mkpem {
	if [[ -z "$1" ]] || [[ -z "$2" ]]; then 
		echo "Missing arguments. mkpem <path-to-p12> <new-pem-path>"
		exit $e_missingarg
	else
		if [[ -e "$1" ]]; then
			if [[ -e "$2" ]]; then
				echo "$2 already exists. Do you want to replace it?"
				read override
				if [[ "$override" == "yes" ]] || [[ "$override" == "y" ]] || [[ "$override" == "Y" ]] || [[ "$override" == "YES" ]]; then
					openssl pkcs12 -in "$1" -out "$2" -nodes -clcerts
					exit $?
				else
					echo "Process halted; $2 will not be overriden"
					exit $e_interrupted
				fi
			else
				openssl pkcs12 -in "$1" -out "$2" -nodes -clcerts
				exit $?
			fi
		else 
			echo "First argument is not a valid filename"
			exit $e_nofile
		fi
	fi
}

mkpem $1 $2
