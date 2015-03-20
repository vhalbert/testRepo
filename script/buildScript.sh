#!/bin/bash

 
 TEIIDPROJ=$2

 echo "Building Project: $TEIIDPROJ ..."

cd $1/$TEIIDPROJ

if [ "$TEIIDPROJ" = "teiid" ]; then

	export MAVEN_OPTS="-Xms512m -Xmx1024m -XX:PermSize=256m -XX:MaxPermSize=512m"

	mvn -s ./settings.xml clean install -Prelease

#(integration tests) mvn install -Parquillian-tests
#(docs) mvn javadoc:aggregate

	echo "$TEIIDPROJ:  mvn -s ./settings.xml clean install -Prelease" >> ../buildCommands.txt

fi

if [ "$TEIIDPROJ" = "teiid-quickstarts" ]; then

	mvn -s ./settings.xml clean install -Ddist

	echo "$TEIIDPROJ:  mvn -s ../teiid/settings.xml clean install -Ddist" >> ../buildCommands.txt

fi

if [ "$TEIIDPROJ" = "teiid-dashboard" ]; then

	mvn -s ./settings.xml clean install -Pfull

	echo "$TEIIDPROJ:  mvn -s ../teiid/settings.xml clean install -Dfull" >> ../buildCommands.txt

fi

if [ "$TEIIDPROJ" = "teiid-webconsole" ]; then

	mvn -s ./settings.xml clean install

	echo "$TEIIDPROJ:  mvn -s ../teiid/settings.xml clean install " >> ../buildCommands.txt

fi

if [ "$TEIIDPROJ" = "teiid-rhq" ]; then

	mvn -s ./settings.xml clean install

	echo "teiid-rhq:  mvn -s ./settings.xml clean install" >> ../buildCommands.txt

fi

if [ "$TEIIDPROJ" = "teiid-extensions" ]; then

	mvn -s ./settings.xml clean install

	echo "teiid-extensions:  mvn -s ./settings.xml clean install" >> ../buildCommands.txt

fi

if [ "$TEIIDPROJ" = "teiid-tools" ]; then

	mvn -s ./settings.xml clean install

	echo "$TEIIDPROJ:  mvn -s ../teiid/settings.xml clean install " >> ../buildCommands.txt

fi

echo "Built $TEIIDPROJ"

