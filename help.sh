#!/bin/sh

me="$0"

helpPath="$( dirname $me )/topics"

topic="$1"


askedForTopic () {
	
	topic="$1"
	
	helpFile="${helpPath}/${topic}.txt"
	
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
		| sed 's/\.txt//' \
		| sed 's@./@@' \
		| sed '/^.$/d' \
		| sort
	
	echo -e "\n\nHints!\n"
	
	echo -e "\tType \"sh $me\" for topics, or\n"
	
	echo -e "\tType \"sh $me topic\" for information.\n"
	
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
