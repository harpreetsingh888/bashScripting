#!/bin/bash

#@Description: This script runs work related application when i start my laptop only on weekdays
#@Info: Before you run this script do the following:
# 1) Create a file to log error by using the following commands
#    cd /home/$userName/                     $userName denotes your local directory name setup
#    touch startupApplicationlog.txt         This command will create the text file
# 2) As you can see I am running yakuake(terminal), google chrome, scudcloud(slack), skype, thunderbird and phpstorm
#    but you might need to run some different applications. To do so, make sure the executable file is in /usr/bin/ or
#    you have created a soft link for the executable in this directory. For example - Script file to run phpstorm was
#    /usr/local/PHPStorm-141/bin/phpstorm.sh, so i create a sym link using following command:
#    ln -s /usr/local/PHPStorm-141/bin/phpstorm.sh /usr/bin/phpstormlink
# 3) Add this file to /usr/bin/ or usr/local/bin/, I went for /usr/bin/ and make it executable using
#    chmod +x startupApplication.sh
# 4) In Ubuntu, search for "Startup Application" application and click on "Add" button.
# 5) Write the name than click on browse and search for /usr/bin/startupApplication.sh or /usr/local/bin/startupApplication.sh
#    where ever you have saved your script file and hit "Add"

#Variables
DATE=$(date)
DAY=$(date +%a)
CURRENTHOUR=$(date +%k)
CURRENTMINUTE=$(date +%M)
LOGFILE=/home/harpreet/startupApplicationlog.txt
declare -a CHECKAPPLICATIONS=('yakuake' 'google-chrome' 'scudcloud' 'skype' 'phpstormlink' 'thunderbird')
declare -a RUNAPPLICATIONS=()
APPLICATIONS=''

#add applications based on if we want to run the apps or just check it
function populateRunApplications()
{
	eval argument="$1"
	#check current applications
	if [ argument="check" ]
	then
		pos=$(( ${#CHECKAPPLICATIONS[*]} - 1 ))
		last=${CHECKAPPLICATIONS[$pos]}
		#Construct a string consisting of all the applications to run
		for j in ${CHECKAPPLICATIONS[@]}; do
		      if [[ $j == $last ]]
		      then
			 APPLICATIONS="$APPLICATIONS$j"
		      else
			 APPLICATIONS="$APPLICATIONS$j & "
		      fi
		done
	else
	#run current applications
		pos=$(( ${#RUNAPPLICATIONS[*]} - 1 ))
		last=${RUNAPPLICATIONS[$pos]}

		#Construct a string consisting of all the applications to run
		for j in ${RUNAPPLICATIONS[@]}; do
		      if [[ $j == $last ]]
		      then
			 APPLICATIONS="$APPLICATIONS$j"
		      else
			 APPLICATIONS="$APPLICATIONS$j & "
		      fi
		done
	fi	
}

#Only Weekdays
if [ $DAY!=Sat ] && [ $DAY!=Sun ];
then

    #no argument supplied
    if [ "$#" -eq 0 ]
    then
  	#8am or 9am
	    if [ $CURRENTHOUR -eq 8 ] || [ $CURRENTHOUR -eq 9 ]
	    then
		#Check if each application is running or not
		for i in ${!CHECKAPPLICATIONS[@]}; do
		    OUTPUT=$(pgrep -n '$i')

		    #if not than all it to an array to run it later on
		    if [ -z "$OUTPUT" ];
		    then
			CURRENTAPP="${CHECKAPPLICATIONS[$i]}"
			RUNAPPLICATIONS+=($CURRENTAPP)
		    fi
		done
		
		populateRunApplications
	
		#Run applications
		eval $APPLICATIONS || echo "Not able to load applications when the system started on $DATE\n" > $LOGFILE
	    fi
    else
	#check argument
	case "$1" in
	-all)
		populateRunApplications check
	
		#Run applications
		eval $APPLICATIONS || echo "Not able to load applications when the system started on $DATE\n" > $LOGFILE
	;;
	-currentapps)
		populateRunApplications check
		
		echo -e $APPLICATIONS
	;;
	-help)
	echo "USAGE"
	echo -e "-all\tRuns all the applications."

	;;
	*)
	echo -e "Supply a valid option."

	esac	
    fi    
else
exit
fi
