#!/bin/bash

str="preset1,preset2"
echo "The string we are going to split by comma ',' is: $str"
IFS=','

readarray -d , -t splitNoIFS<<< "$str"
echo "Print out the different words separated by comma '',''"
for word in "${splitNoIFS[@]}"; do
	echo $word
done
