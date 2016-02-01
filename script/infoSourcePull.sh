#!/bin/bash

# Absolute path to this script, e.g. /home/user/xxx/infoRlease.sh
SCRIPT="$(cd $(dirname "$0") && pwd)/$(basename "$0")"
# Absolute path this script is in, thus /home/user/xxx
scriptDir=$(dirname "$SCRIPT")


if [ $# != 3 ] ; then
    echo
    echo "Usage:"
    echo "  $0  releaseTag repoUsername repoPassword"
    echo "For example:"
    echo "  $0  sync-6.2.x-2015.03.18 username  password"
    echo
    exit 1
fi

echo "The releaseTag is: "$1
echo "The repo username is: " $2
echo -n "Is this ok? (Hit control-c if is not): "
read ok


productTag=$1
BLD_USERNAME=$2
BLD_PASSWORD=$3
PARMS="$BLD_USERNAME:$BLD_PASSWORD"

cd $scriptDir


# if the repos have already been downloaded, don't re-download, 
# remove manually if u wish to down load again
# in jenkins this won't be an issue with the workspace being cleaned
if [ ! -d "$scriptDir/repos" ]; then
	mkdir $scriptDir/repos
fi


if [ ! -d "$scriptDir/logs" ]; then
	mkdir $scriptDir/logs
fi


if [ -f "$scriptDir/repURLS.txt" ]; then
    rm $scriptDir/repos/repURLS.txt
fi

if [ -f "$scriptDir/logs/releaseTag.txt" ]; then
    rm $scriptDir/logs/releaseTag.txt
fi

echo "$productTag" >> $scriptDir/logs/releaseTag.txt


FILE_TO_READ=$scriptDir/repositories.properties

PREFIX="http://"
cd $scriptDir/repos

   while read line; do
     if [ -n "$line" ]; then
         
       echo "$PREFIX$line" >> repURLS.txt
       
       url="$PREFIX$PARMS$line"
       
       echo "clone: $url"
       
       git clone --branch $productTag $url 
     fi
   done < $FILE_TO_READ
 
cd $scriptDir

echo "Source Code has been checked out"