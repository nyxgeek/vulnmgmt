#!/bin/bash

#2016 @nyxgeek

#figure out where script is running from and cd to that location
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

#check to see if our archive folder exists and if not, create it
if [ ! -e archive ]; then mkdir archive; fi

#ensure permissions are set on scripts
chmod +x mailnotifier.sh mailkeeper.py


#download mail messages
python mailkeeper.py

#grep for our results and send mail
./mailnotifier.sh

#clean up
if [ `ls -la *.mail 2>/dev/null | wc -l` -gt 0 ]; then
	mv *.*.mail ./archive/
fi
