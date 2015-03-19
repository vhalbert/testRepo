#!/bin/bash

 echo "Building Teiid Projects"
 
 TEIIDPROJ=teiid
 
 echo "Building $TEIIDPROJ ... "

cd $1/$TEIIDPROJ

export MAVEN_OPTS="-Xms512m -Xmx1024m -XX:PermSize=256m -XX:MaxPermSize=512m"

mvn -s ./settings.xml clean install -Prelease

echo "$TEIIDPROJ:  mvn -s ./settings.xml clean install -Prelease" >> ../buildCommands.txt

echo "Built $TEIIDPROJ"

#(integration tests) mvn install -Parquillian-tests
#(docs) mvn javadoc:aggregate

TEIIDPROJ=teiid-quickstarts

 echo "Building $TEIIDPROJ ... "

cd $1/$TEIIDPROJ

mvn -s ./settings.xml clean install -Ddist

echo "$TEIIDPROJ:  mvn -s ../teiid/settings.xml clean install -Ddist" >> ../buildCommands.txt

echo "Built $TEIIDPROJ"

TEIIDPROJ=teiid-dashboard

 echo "Building $TEIIDPROJ ... "

cd $1/$TEIIDPROJ

mvn -s ./settings.xml clean install -Pfull

echo "$TEIIDPROJ:  mvn -s ../teiid/settings.xml clean install -Dfull" >> ../buildCommands.txt

echo "Built $TEIIDPROJ"

TEIIDPROJ=teiid-webconsole

 echo "Building $TEIIDPROJ ... "

cd $1/$TEIIDPROJ

mvn -s ./settings.xml clean install

echo "$TEIIDPROJ:  mvn -s ../teiid/settings.xml clean install " >> ../buildCommands.txt

echo "Built $TEIIDPROJ"


echo "Building teiid-rhq... "

cd $1/teiid-rhq

mvn -s ./settings.xml clean install

echo "teiid-rhq:  mvn -s ./settings.xml clean install" >> ../buildCommands.txt

echo "Built teiid-rhq"


echo "Building teiid-extensions... "

cd $1/teiid-extensions

mvn -s ./settings.xml clean install

echo "teiid-extensions:  mvn -s ./settings.xml clean install" >> ../buildCommands.txt

echo "Built teiid-extensions"

#TEIIDPROJ=teiid-tools

# echo "Building $TEIIDPROJ ... "

#cd $1/$TEIIDPROJ

#mvn -s ./settings.xml clean install

#echo "$TEIIDPROJ:  mvn -s ../teiid/settings.xml clean install " >> ../buildCommands.txt

#echo "Built $TEIIDPROJ"

