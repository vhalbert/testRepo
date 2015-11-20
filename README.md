testRepo
========

Assumptions:
-  the tag used on all the projects, for a given release (i.e., ER1, ER2, etc.) will be the same

In this repository are stored files that should serve as information of
which community release is the base for product tag as well as a script file and property files
that construct these files.
    
    
## How to install this repo and run the script

    1. git clone git@github.com:vhalbert/testRepo.git
    
    2. cd tesRepo/script
    
    3. ./infoSourcePull.sh <releaseTag> <reposUsername> <repoPassword>
    
    	-  this will pull the source code based on the tag
    
       	Usage: releaseTag repoUsername repoPassword
    	For example:
    			sync-6.2.x-ER1 username  password

    	Input files:
    		-	repositories.properties    :  contains the (partial) url to each repo to pull
    											change this to add/remove repos to process
    		
    		
    	Outputs:
    		-	repURLS.txt		:  contains the full URL for each repo
					    			this is printed in the report when infoReleaseTag.sh is run
					    			
			-	releaseTag.txt	:	contains the release tag passed in.  This is used by ./infoRelease.sh
    			
    		
    4.	cd testRepo
    
    	run a maven build for each repo, example:
    	
    	mvn  -Dproject=[projectname] -Dscript.log=[pathToScriptDir] -Drepo.loc=[pathToCheckedOutRepos]
    	
    	example:  mvn -Dproject=teiid  -Dscript.loc=$WORKSPACE/script -Drepo.loc=$WORKSPACE/script/repos		
    			
    			
    	There is a jenkins job that has this configured:  https://jenkins.mw.lab.eng.bos.redhat.com/hudson/view/DV/job/teiid-engineering-to-product-handoff-build/
    	
    	
    	Output files:
    		-	$scriptDir/repos/repURLS.txt			:  	contains the repository URL's that were actually processed
    		-	$scriptDir/repos/buildCommands.txt		:	contains the build commands used to build each repo
    		
    	
    3. $ ./infoRelease.sh  <targetProdBuild> <codeCutoffDate>
    
    example:  ./infoRelease.sh  8.7.0.1-prod-ipv6.2 DR1 2015-3-16


		Input files:
			-	releaseTag.txt	:	contains the release tag, which was created by ./infoSourcePull.sh
			
			"Contacts"
			-	mails.properties

			"Sources to Build"
			-	$scriptDir/repos/repURLS.txt
			
			"Build Commands"
			-	$scriptDir/repos/buildCommands.txt
			
		    "Packing details"
		    -	productPackaging.txt
		    
		    "Notes"
		    -	notes.properties
    
The script runs and stores a file with name **productTag-*.txt** in testRepo/reposrts/tags 
<br> The * is a number that increments each time the script runs with the same <productTag> as parameter.
<br>The script gets all information about a productTag from properties-files and from the machine where 
it is stored the repository.<br>
    


## How to add a new project repo

	1.	change repositories.properies, adding the name of the repo
	2.	change repositoryList.properties, adding the name of the repo
	3.	change pom.xml, adding a build section for the repo