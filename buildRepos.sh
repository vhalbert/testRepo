#!/bin/bash

# this is used for building projects

CURDIR="$(cd $(dirname "$0") && pwd)/$(basename "$0")"
# Absolute path this script is in, thus /home/user/xxx
curDir=$(dirname "$CURDIR")

SCRIPTDIR=$curDir/script

FILE_TO_READ=$SCRIPTDIR/repositoryList.properties

if [ -f "$SCRIPTDIR/combinedLog.txt" ]; then
    rm $SCRIPTDIR/combinedLog.txt
fi

	DATETIME=`date +%F-%H:%M`
   echo "Start DateTime: $DATETIME" >>$SCRIPTDIR/combinedLog.txt
   while read line; do
     if [ -n "$line" ]; then
       
       echo "project: $line"
       
       cd $SCRIPTDIR/repos/$line
       
       if [ -f "build.log" ]; then
    		rm build.log
		fi
        
       mvn install -Dproject=$line -Dscript.loc=$SCRIPTDIR -Drepo.loc=$SCRIPTDIR/repos >build.log
       
       LOG=$(tail -100 build.log)
       
       echo "*********************************">>$SCRIPTDIR/combinedLog.txt
       echo " project log: $line">>$SCRIPTDIR/combinedLog.txt
       echo " " >> $SCRIPTDIR/combinedLog.txt
       echo $LOG >> $SCRIPTDIR/combinedLog.txt
     fi
   done < $FILE_TO_READ
   
   DATETIME=`date +%F-%H:%M`
   echo "End DateTime: $DATETIME" >>$SCRIPTDIR/combinedLog.txt
   
cd $CURDIR




