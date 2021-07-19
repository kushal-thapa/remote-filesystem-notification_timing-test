#!/bin/bash



# This script describes all the variables used in this program

#=========================================================================================================================#

# Note: Command line arguments -i (Iteration) and -c (test command) are set directly when running the main.sh script

#=========================================================================================================================#

# SSHFS configuration
Server="droplet"
Server_path=/mnt/DAQ/kushal/timing_test_data
Local_mnt_path=~/Desktop/droplet_mnt

#=========================================================================================================================#

# Local path to store error files (Used in data_checker.sh)
Error_path=~/Desktop/timing_test_error_data

# SSHFS mnt directory to store data and  log files
#Data_path=~/Desktop/droplet_mnt/timing_test_data
#Log_path=~/Desktop/droplet_mnt/log_files

#=========================================================================================================================#

# Receipents phone#/email (used in send_text.sh)
RCPT='4056388015@msg.fi.google.com'

#=========================================================================================================================#

# Connection Names in the ~/.ssh/config files

### Architecture 0: Laptop-Satellite (Same Network)
connection1="dell-mplx"     # Multiplexed connection to satellite
connection2="dell"          # Unmultiplexed connection to satellite

### Architecture 1: Laptop-Droplet-Satellite
connection3="hp-jump-tunnel-mplx"         # Multiplexed jump tunnel
connection4="hp-jump-tunnel"              # Unmultiplexed jump tunnel
connection5="dell-jump-tunnel-mplx"       # Multiplexed jump tunnel from server side
connection6="dell-jump-tunnel"            # Unmultiplexed jump tunnel from server side
connection7="hp-jump-dell-mplx"           # Multiplexed laptop-droplet-server 
connection8="hp-jump-dell"                # Unmultiplexed laptop-droplet-server

### Architecture 2: Droplet-Satellite
connection9="jumpbox"                     # Multiplexed connection from satellite to droplet
connection10="droplet"                    # Unmultiplexed connection from satellite to droplet
connection11="localhost-mplx"             # Multiplexed connection from droplet to satellite
# Note: Unmultiplexed connection from droplet to satellite is just "localhost"

# Reverse ssh ports used in Architecture 2
Port_mplx=7001
Port_nonmplx=7000
#=========================================================================================================================#
