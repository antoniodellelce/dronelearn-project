#!/bin/bash
#
# File:         welcome.sh
# Created:      150518
# Description:  welcome message to help in Blazemeter work
#

### FUNCTIONS ###

lastwelcome()
{
 typeset now="$(date +%s)" # should be time to save
 typeset lastwelcomeenv=${PROJECT}_lastwelcome

 # read
 lastwelcome=$(penv $lastwelcomeenv | grep -v 'not set')
 penv $lastwelcomeenv=$now # should test success here

 [ -z "$lastwelcome" ] && { echo "  First login to ${PROJECT}!"; return; }

 let elapsed="(( $now - $lastwelcome ))"

 # should check if: show days? show hours etc...
 [ $elapsed -gt 3600 ] &&
 {
  let elapsed_hr="(( $elapsed / 3600 ))"
  echo "  Last \"login\": ${COL}$elapsed_hr${RESET} hours ago."
 } ||
 {
  [ $elapsed -gt 60 ] &&
  {
   let elapsed_min="(( $elapsed / 60 ))"
   echo "  Last \"login\": ${COL}$elapsed_min${RESET} minutes ago."
  } ||
  {
   echo "  Last \"login\": ${COL}$elapsed${RESET} seconds ago."
  }
 }

 #
 penv $lastwelcomenv=$now  # should test success here
}

### ENV ###

 export ESC=""
 export BOLD="${ESC}[1m"
 export RESET="${ESC}[0m"
 export RED="${ESC}[31m"
 export GREEN="${ESC}[32m"
 export COL="${BOLD}${GREEN}"

### EOF ###
