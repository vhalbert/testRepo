#!/bin/bash

# Absolute path to this script, e.g. /home/user/xxx/infoRlease.sh
SCRIPT="$(cd $(dirname "$0") && pwd)/$(basename "$0")"
# Absolute path this script is in, thus /home/user/xxx
scriptDir=$(dirname "$SCRIPT")


if [ $# != 1 ] ; then
    echo
    echo "Usage:"
    echo "  $0  releaseTag"
    echo "For example:"
    echo "  $0  sync-6.2.x-ER1"
    echo
    exit 1
fi

echo "The releaseTag is: "$1
echo -n "Is this ok? (Hit control-c if is not): "
read ok


productTag=$1

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

if [ -f "$scriptDir/releaseTag.txt" ]; then
    rm $scriptDir/releaseTag.txt
fi


echo "$productTag" >> $scriptDir/logs/releaseTag.txt


FILE_TO_READ=$scriptDir/projectRepositories.properties

cd $scriptDir/repos

   while read line; do
     if [ -n "$line" ]; then
         
       echo "$line" >> repURLS.txt
       
       echo "clone: $line"
       
       git clone --branch $1 $line
     fi
   done < $FILE_TO_READ
 
cd $scriptDir

echo "Source Code has been checked out"