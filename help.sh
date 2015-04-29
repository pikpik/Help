helpPath="$( dirname $0 )/topics"

topic="$1"


askedForTopic () {
	
	topic="$1"
	
	helpFile="${helpPath}/${topic}.md"
	
	if [ -f "$helpFile" ]
	
	then
		
		showTopic "$helpFile"
		
	else
		
		topicNotFound "$topic"
				
		showTopics
		
	fi
	
}

topicNotFound () {
	
	topic="$1"
	
	echo -e "\nSorry, ${topic} not found.\n"
	
}

showTopics () {
	
	echo -e "\nAvailable topics:\n"
	
	cd "$helpPath"
	
	find . -type f \
		| sed 's/\.md//' \
		| sed 's@./@@' \
		| sed '/^.$/d' \
		| sort
	
	echo ""
	
}

showTopic () {
	
	helpFile="$1"
	
	less "$helpFile"
	
}


if [ ! "$topic" = "" ]

then
	
	askedForTopic "$topic"
	
else
	
	showTopics
	
fi
