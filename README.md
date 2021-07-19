# remote-filesystem-notification_timing-test
<p>
1.       cmdline_arguments.sh: This script enables the program to take two command line arguments. -i for number of iterations to be performed (default is 30) and 
-c for the command itself (default is ls -als). 
</p>
2.       variables.sh: This is a script where all the external variables can be set for the entire program. For example, the connection names, sshfs directories path and 
every variable that is used in the rest of the program can be set here. 
</p>
3.       check_config.sh: This script checks the ~/.ssh/config files of all the machines involved in the program for the connections defined in variables.sh. 
If there are any problems, it stdouts error message.
</p>
4.       connections_setup.sh: This script:<br>
         a.       Checks the output of the check_config.sh, and exits if there are any problems.<br>
         b.       Mounts SSHFS, and if it fails, exits the program. <br>
         c.       Sets up intermediary (e.g. laptop-jump-tunnel) and multiplexed connections (e.g. laptop-jump-satellite-mplx)
</p>
5.       send_text.sh: This script contains a function which enables to send text message. This function is utilized:<br>
         a.       If there are problems in ssh config files and the program exits (in connections_setup.sh).<br>
         b.       If there is a problem in sshfs mounting and the program exits (in connections_setup.sh).<br>
         c.       When the data is acquired (either it is successful or not) (in data_checker.sh).
</p>
6.       data_checker.sh: This script is invoked in main.sh after data is acquired. It checks if the acquired data has any alphabets. 
The data should be all numbers unless some error occurred. There are three conditions in this script:<br>
         a.       Data acquired successfully: meaning all of the data were numbers. Sends a text that data acquiring process went successfully.<br>
         b.       One line of data that was acquired has strings: If this error occurs, the non-numeric entry is deleted and the rest 
         is preserved. However, the original file with one error is saved locally. Also, a text message is sent saying 
         one error was found in the file.<br>
         c.       Something went very wrong: If something went wrong with the connection, there there should be a lot of error messages in the file.
         If that happens then it is saved locally but it doesn’t get uploaded. Then, a text message is sent saying there were major errors in the file.
</p>
7.       main.sh : This is the main script of the program. All the previous scripts are sourced (directly or indirectly), 
and the data is acquired, checked (with data_checker.py), connections are killed and the stdout is tee(ed) to a .log file. 
This log file is then sent to the droplet (/mnt/DAQ/kushal/timing_test_log).
</p>

