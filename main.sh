#!/bin/bash


# This is the main script that collects and files data from different network architectures

#=================================================================================================#
filename=$(date "+%Y.%m.%d-%H.%M.%S")

{
# Sourcing necessary scripts 
source cmdline_arguments.sh
source connections_setup.sh

# Time function
# Usage: ssh_time destination command
ssh_time() {
     /usr/bin/time -f "%e" ssh $1 $2 1> /dev/null
     }

# Acquiring data
echo -e "Acquiring data..\n"

for i in `seq $ITER`;
   do
	# Architecture 0
        ssh_time $connection1 $CMD;
        ssh_time $connection2 $CMD;

        # Architecture 1
        ssh_time $connection7 $CMD;
        ssh_time $connection8 $CMD;

        # Architecture 2
        # Haven't figured out how to use the ssh_time function here
        #echo `ssh_time "$connection11 -p $Port_mplx" $CMD | ssh $connection9 /bin/bash;
        #echo `ssh_time "localhost -p $Port_nonmplx" $CMD | ssh $connection10 /bin/bash;
        echo "/usr/bin/time -f "%e" ssh $connection11 -p $Port_mplx $CMD 1> /dev/null" | ssh droplet /bin/bash; # Multiplexed
        echo "/usr/bin/time -f "%e" ssh localhost -p $Port_nonmplx $CMD 1> /dev/null" | ssh droplet /bin/bash; # Non-multiplexed

        let percent=i*100/$ITER
        echo -en "\r$percent % complete"
   done 2> $filename
echo -e "\n"
sleep 2

/bin/bash data_checker.sh $filename

echo -e "\n"
echo -e "Acquring complete\n"
rm $filename
sleep 1

#============================================================================================================#

# Finishing
echo -e "Killing connections..\n"
sleep 1
echo "pkill autossh" | ssh $connection2 /bin/bash
pkill autossh
fusermount -u $Local_mnt_path

echo "Finished."
} | tee $filename.log
scp $filename.log droplet:/mnt/DAQ/kushal/timing_test_log
rm $filename.log
