#!/bin/bash



TEIIDPROJ=teiid

if [ ! -d "$1/$TEIIDPROJ" ]; then
	echo "Project: $TEIIDPROJ was not checkout"
	
else

	cd $1/$TEIIDPROJ

	export MAVEN_OPTS="-Xms512m -Xmx1024m -XX:PermSize=256m -XX:MaxPermSize=512m"

	mvn -s ./settings.xml clean install -Prelease

#(integration tests) mvn install -Parquillian-tests
#(docs) mvn javadoc:aggregate

	echo "$TEIIDPROJ:  mvn -s ./settings.xml clean install -Prelease" >> ../buildCommands.txt

fi

TEIIDPROJ=teiid-quickstarts

if [ ! -d "$1/$TEIIDPROJ" ]; then
	echo "Project: $TEIIDPROJ was not checkout"
	
else
	cd $1/$TEIIDPROJ

	mvn -s ./settings.xml clean install -Ddist

	echo "$TEIIDPROJ:  mvn -s ../teiid/settings.xml clean install -Ddist" >> ../buildCommands.txt

fi

TEIIDPROJ=teiid-dashboard

if [ ! -d "$1/$TEIIDPROJ" ]; then
	echo "Project: $TEIIDPROJ was not checkout"
	
else

	cd $1/$TEIIDPROJ

	mvn -s ./settings.xml clean install -Pfull

	echo "$TEIIDPROJ:  mvn -s ../teiid/settings.xml clean install -Dfull" >> ../buildCommands.txt

fi

TEIIDPROJ=teiid-webconsole

if [ ! -d "$1/$TEIIDPROJ" ]; then
	echo "Project: $TEIIDPROJ was not checkout"
	
else

	cd $1/$TEIIDPROJ

	mvn -s ./settings.xml clean install

	echo "$TEIIDPROJ:  mvn -s ../teiid/settings.xml clean install " >> ../buildCommands.txt

fi

TEIIDPROJ=teiid-rhq

if [ ! -d "$1/$TEIIDPROJ" ]; then
	echo "Project: $TEIIDPROJ was not checkout"
	
else

	cd $1/$TEIIDPROJ

	mvn -s ./settings.xml clean install

	echo "teiid-rhq:  mvn -s ./settings.xml clean install" >> ../buildCommands.txt

fi

TEIIDPROJ=teiid-extensions

if [ ! -d "$1/$TEIIDPROJ" ]; then
	echo "Project: $TEIIDPROJ was not checkout"
	
else

	cd $1/$TEIIDPROJ

	mvn -s ./settings.xml clean install

	echo "teiid-extensions:  mvn -s ./settings.xml clean install" >> ../buildCommands.txt

fi

TEIIDPROJ=teiid-tools

if [ ! -d "$1/$TEIIDPROJ" ]; then
	echo "Project: $TEIIDPROJ was not checkout"
	
else

	cd $1/$TEIIDPROJ

	mvn -s ./settings.xml clean install

	echo "$TEIIDPROJ:  mvn -s ../teiid/settings.xml clean install " >> ../buildCommands.txt

fi

echo "Built $TEIIDPROJ"

