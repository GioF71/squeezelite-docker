#!/bin/bash

echo "****Example to show use of IFS to split a string****"
IFS=','
str="preset1,preset2,preset3,,"
echo "The string we are going to split by hyphen ',' is: $str"
read -rasplitIFS<<< "$str"
echo "Print out the different words separated by hyphen '-'"
for word in "${splitIFS[@]}"; do
	if ! [ -z "${word}" ]; then
		echo $word;
	else
		echo "---EMPTY---";
	fi
done
echo "Setting IFS back to whitespace"
IFS=''

