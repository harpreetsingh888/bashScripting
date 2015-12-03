#!/bin/bash

#tput setab [1-7] # Set the background colour using ANSI escape
#tput setaf [1-7] # Set the foreground colour using ANSI escape


NONE='\033[00m'
RED='\033[01;31m'
GREEN='\033[01;32m'
YELLOW='\033[01;33m'
PURPLE='\033[01;35m'
CYAN='\033[01;36m'
WHITE='\033[01;37m'
BOLD='\033[1m'
UNDERLINE='\033[4m'

#Argument is Supplied
if [ -z "$1" ]
then

sudo clear

#Clear templates
COUNT=$(ls -1 libs/smarty/templates_c | wc -l)
if [ ${COUNT} > 0 ]

then
rm -rf libs/smarty/templates_c/*
echo "${RED}${BOLD}Cleared Cached Templates${NONE}"

else
echo "${RED}${BOLD}No Cached Templates${NONE}"
fi

#Cache clear
sudo rm -rf app/cache && app/console cache:clear && app/console cache:warmup
echo "${RED}${BOLD}Cache Cleared${NONE}"


#assets install html
sudo app/console assets:install htmlpos
echo "${RED}${BOLD}Assets Installed in htmlpos${NONE}"

#assets install html
sudo app/console assets:install html
echo "${RED}${BOLD}Assets Installed in html${NONE}\n"

#assetic dump
sudo rm -f html/css/compiled/*.css && rm -f html/js/compiled/*.js && app/console assetic:dump

echo "${RED}${BOLD}DONE${NONE}"

# No Argument is supplied
else
case "$1" in
-d)
sudo rm -f html/css/compiled/*.css && rm -f html/js/compiled/*.js && app/console assetic:dump
echo "${RED}${BOLD}Dumped assetic stuff${NONE}"
;;

-dw)
sudo app/console assetic:dump --watch
;;

-c)
#Cache clear
sudo rm -rf app/cache && app/console cache:clear && app/console cache:warmup
echo "${RED}${BOLD}Cache Cleared${NONE}" 	
;;

-t)
#Clear templates
COUNTT=$(ls -1 libs/smarty/templates_c | wc -l)

if [ ${COUNTT} > 0 ]
then
rm -rf libs/smarty/templates_c/*
echo "${RED}${BOLD}Cleared Cached Templates${NONE}"

else
echo "${RED}${BOLD}No Cached Templates${NONE}"
fi
;;

-a)
#assets install html
sudo app/console assets:install htmlpos
echo "${RED}${BOLD}Assets Installed in htmlpos${NONE}\n"		
;;

-ah)
#assets install html
sudo app/console assets:install html
echo "${RED}${BOLD}Assets Installed in html${NONE}\n"		
;;

-help)
echo "${RED}${BOLD}usage sh clean.sh ${NONE}"
echo "${RED}${BOLD}-d\tDumps assetic ${NONE}"
echo "${RED}${BOLD}-dw\tDumps assetic and watch${NONE}"
echo "${RED}${BOLD}-c\tClear symfony ache${NONE}"
echo "${RED}${BOLD}-t\tRemove cached templates${NONE}"
echo "${RED}${BOLD}-a\tDump assets htmlpos${NONE}"
echo "${RED}${BOLD}-ah\tDump assets html${NONE}"

;;
*)
echo "${RED}${BOLD}Supply a valid option${NONE}"

esac

fi

#remove file generated
if [ -f 0 ]; then
rm 0
fi
