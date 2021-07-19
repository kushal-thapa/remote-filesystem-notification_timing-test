#!/bin/bash



# This script sets up command line arguments for the main program

# Usage example: ./main.sh -i 30 -c "ls -als"; where 'i' is iterations and 'c' is command

#=====================================================================================================#

echo -e "Input Parameters: \n"
sleep 1

usage() { echo "Usage: $0 [-i <1..50 (Default is 30)>] [-c <command string (Default is 'ls -als'>]" 1>&2; exit 1; }

while getopts ":i:c:" flags; do
    case "${flags}" in
        i) i=${OPTARG};;
        c) c=${OPTARG};;
        *) usage;;
    esac
done
shift $((OPTIND-1))

# Setting up default options
if [ -z "${i}" ]; then
    i=30
fi
if [ -z "${c}" ]; then
    c="ls -als"
fi

ITER=$i
CMD=$c

echo "Number of iterations set = ${ITER}"
echo -e "Command set= ${CMD}\n"
sleep 1

