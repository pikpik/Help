# Stop on errors

set -e


# Define where the topic directory is.

helpPath="$( dirname $me )/topics"


# Define the file viewer

fileViewer="more"


getPagerBasedOnFileLines () {
	
	filePath="$1"
	
	consoleLines=$( tput lines )
	
	totalFileLines=$( wc -l "$filePath" | sed -r 's/ .+?$//' )
	
	if [ $totalFileLines -gt $consoleLines ]
	
	then
		
		echo "less"
		
	else
		
		echo $( getPagerBasedOnFileLinesWrapped "$filePath" )
		
	fi
	
}

getPagerBasedOnFileLinesWrapped () {
	
	filePath="$1"
	
	consoleLines=$( tput lines )
	consoleCols=$( tput cols )
	
	cat "$filePath" \
		| awk "
			BEGIN {
				
				totalLinesUsed = 0;
				
			}
			
			{
				
				lineLength = length ();
				
				consoleLinesUsedByLine = int ( lineLength / $consoleCols ) + 1;
				
				totalLinesUsed += consoleLinesUsedByLine;
				
			}
			
			END {
				
				if ( totalLinesUsed < $consoleLines ) {
					
					printf \"cat\";
					
				} else {
					
					printf \"less\";
					
				}
				
			}
		"
	
}

mess () {
	
	filePath="$1"
	
	pager=$( getPagerBasedOnFileLines "$filePath" )
	
	$pager "$filePath"
	
}

fileViewer="mess"


# Other things can be set here too.
