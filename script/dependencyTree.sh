#!/bin/bash

# Absolute path to this script
SCRIPT="$(cd $(dirname "$0") && pwd)/$(basename "$0")"
# Absolute path this script is in
scriptDir=$(dirname "$SCRIPT")
cd ..

rootDir=$(pwd)
targetDir=$rootDir/reports/dependencyTree
cd $targetDir
mkdir $PRODUCT_TAG-$counter

cd $scriptDir
cd ../

FILE_TO_READ=$scriptDir/repositoryList.properties
   while read line; do
     if [ -n "$line" ]; then
       cd $scriptDir/repos/$line
       pwd   
       repository=$line
       echo "repository="$repository
       mvn -s ./settings.xml dependency:tree | grep "^\[INFO\]" > $repository.txt
       mv $repository.txt $targetDir/$dependencyDir
       cd ..
     fi
   done < $FILE_TO_READ
