#!/bin/bash



# This script sets up intermediary connections plus initiates multipexed connections for the main program: "main.sh"

#=====================================================================================================================#

# Sourcing check_config.sh script and checking if there are any errors on config files
# Exiting if there are ssh config errors

source check_config.sh
source send_text.sh
echo -e "\n"

error_check=`/bin/bash check_config.sh | grep "ERROR" `
   if [ -z "$error_check" ]
   then
   	echo "No errors found on the ssh config files"
   else
        echo "Errors found on the ssh config files"
        send_text "SSH config errors"
        echo "EXITING PROGRAM"
        exit
   fi

#-------------------------------------------------------------------------------------------------------#

echo -e "Setting up connections..\n"
sleep 1

# SSHFS mounting (exiting if it fails)
if !( sshfs $Server:$Server_path $Local_mnt_path ); then
  echo -e "ERROR: SSHFS Mounting failed!\n"
  send_text "SSHFS Mounting failed"
  exit 1
else
  echo -e "SSHFS mount successful\n"
fi
sleep 1

#--------------------------------------------------------------------------------------------------------#

### Architecture 0: Laptop-Satellite (Same Network)
echo -e "Architecture 0: Laptop-Satellite (Same Network)\n"
sleep 1

ssh $connection1 echo "- Laptop to satellite multiplexed: Active"      # Setting up initial background multiplexed ssh connection
echo -e "\n"
sleep 1

#--------------------------------------------------------------------------------------------------------#

### Architecture 1: Laptop-Droplet-Satellite
echo -e "Architecture 1: Laptop-Droplet-Satellite\n"
sleep 1

# 1: Setting up background tunnels from master(laptop) to droplet
echo "Step 1: Setting up background tunnels from master(laptop) to droplet"
sleep 1
ssh $connection3 echo "- Laptop-jump-tunnel-mplx: Active"     # Multiplexed
autossh -M 0 -f -T -N $connection4          # Non-multiplexed
echo -e "- Laptop-jump-tunnel: Active\n"
sleep 1

# 2: Setting up background tunnels from satellite to droplet
echo "Step 2: Setting up background tunnels from satellite to droplet"
sleep 1
echo "autossh -M 0 -f -T -N $connection5" | ssh dell /bin/bash   # Multiplexed
echo "- Satellite-jump-tunnel-mplx: Active"
echo "autossh -M 0 -f -T -N $connection6" | ssh dell /bin/bash        # Non-multiplexed
echo -e "- Satellite-jump-tunnel: Active\n"
sleep 1

# 3: Setting up initial background multiplexed connection from master to satellite
echo "Step 3: Setting up initial background multiplexed connection from master to satellite"
sleep 3

ssh $connection7 echo "- Laptop-jump-Satellite-mplx: Active"
echo -e "\n"
sleep 1

#-------------------------------------------------------------------------------------------------------#

### Architecture 2: Droplet-Satellite
echo -e "Architecture 2: Droplet-Satellite\n"
sleep 1

# 1. Setting up connection from satellite (behind firewall)  to droplet
echo "Step 1: Setting up connection from satellite (behind firewall)  to droplet"
sleep 1
echo "autossh -M 0 -f -T -N -R 7001:localhost:22 $connection9" | ssh dell /bin/bash      # Multiplexed
echo "- satellite to droplet multiplexed: Active"
echo "autossh -M 0 -f -T -N -R 7000:localhost:22 $connection10" | ssh dell /bin/bash     # Non-multiplexed
echo -e "- satellite to droplet non-multiplexed: Active\n"
sleep 1

# 2. Setting up intial background multiplexed connection from droplet to satellite
echo "Step 2: Setting up intial background multiplexed connection from droplet to satellite"
sleep 1
echo "ssh $connection11 -p 7001 echo "- Droplet to satellite multiplexed: Active"" | ssh droplet /bin/bash
echo -e "\n"
sleep 1

echo -e "Setup complete\n"
sleep 1

