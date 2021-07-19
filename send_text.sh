#!/bin/bash



# This script (function) sends text 

#=============================================================================#

source variables.sh

send_text() {
  PRNT='/usr/bin/printf'
  MAIL='/usr/bin/msmtp'
  DATE=`date +"%F"`
  TIME=`date +"%T"`
  SUBJ='Data acquiring notice' 
  EMSG=$1
  $PRNT "Subject: $SUBJ\n$DATE\n$TIME\n\n $EMSG"  | $MAIL $RCPT
}

