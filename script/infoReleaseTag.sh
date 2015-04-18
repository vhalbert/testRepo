#!/bin/bash

# Absolute path to this script, e.g. /home/user/xxx/infoRlease.sh
SCRIPT="$(cd $(dirname "$0") && pwd)/$(basename "$0")"
# Absolute path this script is in, thus /home/user/xxx
scriptDir=$(dirname "$SCRIPT")


if [ $# != 2 ] ; then
    echo
    echo "Usage:"
    echo "  $0  targetProdBuild cutOffDate"
    echo "For example:"
    echo "  $0  ER6 2015-02-27"
    echo
    exit 1
fi

#echo "The prodcutTag is: "$1
echo "The target product build is: "$1
echo "The cutoff date is: " $2
echo -n "Is this ok? (Hit control-c if is not): "
read ok

#productTag=$1
targetProdBuild=$1
cutOffDate=$2


cd $scriptDir

if [ ! -d "../reports" ]; then
	mkdir ../reports
fi

if [ ! -d "../reports/tags" ]; then
	mkdir ../reports/tags
fi

if [ ! -d "../reports/dependencyTree" ]; then
	mkdir ../reports/dependencyTree
fi


PRODUCT_TAG=$(cat releaseTag.txt)

mv $scriptDir/repos/repURLS.txt $scriptDir
mv $scriptDir/repos/buildCommands.txt $scriptDir

# where are the files stored
cd ../reports/tags
fileDir=$(pwd)


#checks if $productTag is already existing in a filename
cd $fileDir
LIST=$(find . -name "$PRODUCT_TAG*.txt" | sort)

# all filename containing $productTag are listed. The filename with the highest *.txt is listed as last.
# The LIST is reverted and the value * extracted
counter=$(echo $LIST | rev | cut -c5)
oneFile=$PRODUCT_TAG-$counter.txt

if [ -f $oneFile ];
   then 
   counter=$((counter + 1))
 else
   counter=1
fi    

# name of file to be written and pushed  
fileToWrite=$PRODUCT_TAG-$counter.txt

cd $scriptDir

CONTACTS=$(cat mails.properties)

#FILE_TO_READ=$scriptDir/repositories.properties

REPOSITORIES=$(cat repURLS.txt)
MAVEN=$(mvn -version)
NOTES=$(cat notes.properties)
PACKAGE=$(cat productPackaging.txt)
BLDCOMMAND=$(cat buildCommands.txt)
# JAVA version as it needs a workaround
java -version 2>>javaVersion.txt
JAVAV=$(cat javaVersion.txt)
DATETIME=`date +%F-%H:%M`


cat <<EOF >$fileToWrite

------------------------------------------------------------------------
           Teiid (DV) Engineering to Productization Handoff Report
------------------------------------------------------------------------
Report Date: $DATETIME
Code Cutoff Date: $cutOffDate
Target Product Build: $targetProdBuild
Source Product Tag: $PRODUCT_TAG

 
Product Page: 
https://pp.engineering.redhat.com/pp/product/eds/overview

-----------------------------------------------------------------------  
                     Component owners contacts                           
------------------------------------------------------------------------
$CONTACTS

------------------------------------------------------------------------
                          Build Tools                               
------------------------------------------------------------------------
JAVA: 
$JAVAV

MAVEN: 
$MAVEN

------------------------------------------------------------------------
                        Sources to build                         
------------------------------------------------------------------------
$REPOSITORIES

------------------------------------------------------------------------
                          Build Commands
------------------------------------------------------------------------

$BLDCOMMAND

------------------------------------------------------------------------
                       Environment variables
------------------------------------------------------------------------ 

MAVEN_OPTS:
$MAVEN_OPTS

-----------------------------------------------------------------------  
Build artifacts for product, installation location, and configuration                           
------------------------------------------------------------------------
$PACKAGE


------------------------------------------------------------------------
                              Notes                                     
------------------------------------------------------------------------
$NOTES



EOF

# makes missing directories for the dependency:trees
   cd $scriptDir
   cd ../reports/dependencyTree
   mkdir $PRODUCT_TAG-$counter
   export dependencyDir=$PRODUCT_TAG-$counter
   cd $scriptDir
   rm javaVersion.txt
   mv $fileToWrite $fileDir/
#creates the dependensyTrees
./dependencyTree.sh
# pushes $fileToWrite to the blessed repository
#   git add $fileToWrite
#   git commit -m "$productTag"
   # best not to push automatically as it is always possible we need 
   # to fix something locally before pushing
   #git push origin master