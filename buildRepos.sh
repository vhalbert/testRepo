#!/bin/bash

# this is used for building projects

CURDIR="$(cd $(dirname "$0") && pwd)/$(basename "$0")"
# Absolute path this script is in, thus /home/user/xxx
curDir=$(dirname "$CURDIR")

SCRIPTDIR=$curDir/script

FILE_TO_READ=$SCRIPTDIR/repositoryList.properties



   while read line; do
     if [ -n "$line" ]; then
       
       echo "project: $line"
       
       cd $SCRIPTDIR/repos/$line
        
       mvn install -Dproject=$line -Dscript.loc=$SCRIPTDIR -Drepo.loc=$SCRIPTDIR/repos
     fi
   done < $FILE_TO_READ
   
cd $CURDIR




