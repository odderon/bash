#!/bin/bash

# add this to the end of your script to parse function-name arguments.

FLIST=( `typeset -f | awk '/ \(\) $/ {print $1}'` )
for FNAME in "${FLIST[@]}"; do
	if [[ "$1" == "$FNAME" ]]; then
		shift
		${FNAME} $@
		exit $?
	fi
done

if [[ ! -z "$1" ]]; then
	echo "$1 is not a valid function name for this script."
else
	echo "Please enter a function name."
fi
