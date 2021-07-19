#!/bin/bash



# This script checks the acquired data (from main.sh) for any strings which would indicate some kind of errors. Then, based on the check
# result, a text is sent (using send_text.sh). This script is invoked in the main.sh after data acquiring process.

#========================================================================================================================================#

source send_text.sh  # Script that defines a function to send text

filename=$1
check_for_strings=`egrep -c 'a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|z|y|z' $filename`
   if [ "$check_for_strings" -eq 0 ]
   then
        echo "Data acquiring process went smoothly"
        cat $filename | paste - - - - - -> $Local_mnt_path/$filename.csv
        send_text "$filename was successfully acquired"
   elif [ "$check_for_strings" -eq 1 ]
   then
        echo "Number of lines with strings $check_for_strings"
        cat $filename > $Error_path/$filename.1error
        egrep -v 'a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|z|y|z' $filename > $Error_path/$filename.1error.solv
        cat $Error_path/$filename.1error.solv | paste - - - - - -> $Local_mnt__path/$filename.csv
        send_text "$filename had 1 error which was removed"  
   else
        echo "Number of lines with strings $check_for_strings"
        cat $filename > $Error_path/$filename.loterrors
        send_text "Error in $filename acquiring process"
   fi

