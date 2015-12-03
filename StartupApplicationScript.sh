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

DATE=$(date)
DAY=$(date +%a)
CURRENTHOUR=$(date +%k%M)
CURRENTMINUTE=$(date +%k%M)
LOGFILE=/home/harpreet/startupApplicationlog.txt

if [ $DAY -ne 'Sat' ] && [ $DAY -ne 'Sun' ]
then
    if [ $CURRENTHOUR -eq 9 ]
    then
        #run all the application related to work
        yakuake & google-chrome & scudcloud & skype & thunderbird & phpstormlink
    fi
fi
