#!/bin/bash

NONE='\033[00m'
RED='\033[01;31m'
GREEN='\033[01;32m'
YELLOW='\033[01;33m'
PURPLE='\033[01;35m'
CYAN='\033[01;36m'
WHITE='\033[01;37m'
BOLD='\033[1m'
UNDERLINE='\033[4m'

#No Argument is Supplied
if [ -z "$1" ]
then

sudo clear

#Clear templates
COUNT=$(ls -1 libs/smarty/templates_c | wc -l)
if [ ${COUNT} > 0 ]

then
rm -rf libs/smarty/templates_c/*
echo -e "${RED}${BOLD}Cleared Cached Templates${NONE}"

else
echo "${RED}${BOLD}No Cached Templates${NONE}"
fi

#Cache clear
sudo app/console cache:clear
echo "${RED}${BOLD}Cache Cleared${NONE}"

#assets install html
sudo app/console assets:install
echo "${RED}${BOLD}Assets Installed in htmlpos${NONE}"

#assetic dump
sudo app/console assetic:dump

echo -e "${RED}${BOLD}DONE${NONE}"

#Argument is supplied
else
case "$1" in
-d)
sudo app/console assetic:dump
echo "${RED}${BOLD}Dumped assetic stuff${NONE}"
;;

-dw)
sudo app/console assetic:dump --watch
;;

-c)
#Cache clear
sudo app/console cache:clear
echo "${RED}${BOLD}Cache Cleared${NONE}"     
;;

-t)
#Clear templates
#COUNTT=$(ls -1 libs/smarty/templates_c | wc -l)

#if [ ${COUNTT} > 0 ]
#then
#rm -rf libs/smarty/templates_c/*
#echo "${RED}${BOLD}Cleared Cached Templates${NONE}"

#else
#echo "${RED}${BOLD}No Cached Templates${NONE}"
#fi
;;

-a)
#assets install html
sudo app/console assets:install htmlpos
echo "${RED}${BOLD}Assets Installed in htmlpos${NONE}\n"        
;;

-help)
echo "${RED}${BOLD}usage sh clean.sh ${NONE}"
echo "${RED}${BOLD}-d\tDumps assetic ${NONE}"
echo "${RED}${BOLD}-d\tDumps assetic and watch${NONE}"
echo "${RED}${BOLD}-c\tClear symfony ache${NONE}"
echo "${RED}${BOLD}-t\tRemove cached templates${NONE}"
echo "${RED}${BOLD}-a\tDump assets${NONE}"

;;
*)
echo "${RED}${BOLD}Supply a valid option${NONE}"

esac

fi
