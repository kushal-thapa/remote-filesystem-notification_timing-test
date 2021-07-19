#!/bin/bash



# This script checks the ssh config files of all machines in the network for necessary configurations

# Note: The output of this script is checked by connections_setup.sh to check for errors in the ssh config files
#=========================================================================================================================#

source variables.sh

echo -e "Checking the ~/.ssh/config files for necessary network configurations\n"
sleep 1

path=~/.ssh/config

# Function for checking the config file of the local system
check_config() {
   check=`grep $1 $path`
   if [ -z "$check" ]
   then
   	echo "ERROR: $1 Connection not found"
   else
        echo "$1 is OK"
   fi
   }

# Function for checking the config file of the remote system
check_remote_config() {
   check_remote=`ssh $1 grep $2 $path`
   if [ -z "$check_remote" ]
   then
	echo "ERROR: $2 connection not found"
   else
        echo "$2 is OK"
   fi
   }

# Checking the configurations
check_config $connection1 
check_config $connection2 
check_config $connection3
check_config $connection4 
check_remote_config dell $connection5 
check_remote_config dell $connection6
check_config $connection7 
check_config $connection8 
check_remote_config dell $connection9 
check_remote_config dell $connection10 
check_remote_config droplet $connection11 




