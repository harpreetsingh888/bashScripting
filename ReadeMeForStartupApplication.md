Before you run this script do the following:
1) Create a file to log error by using the following commands
   cd /home/$userName/                     $userName denotes your local directory name setup
   touch startupApplicationlog.txt         This command will create the text file
2) As you can see I am running yakuake(terminal), google chrome, scudcloud(slack), skype, thunderbird and phpstorm
   but you might need to run some different applications. To do so, make sure the executable file is in /usr/bin/ or
   you have created a soft link for the executable in this directory. For example - Script file to run phpstorm was
   /usr/local/PHPStorm-141/bin/phpstorm.sh, so i create a sym link using following command:
   ln -s /usr/local/PHPStorm-141/bin/phpstorm.sh /usr/bin/phpstormlink
