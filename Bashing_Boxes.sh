#!/bin/bash
random_array=(
	"cookie jar" 
	"sweater" 
	"sword" 
	"curtain rod" 
	"tree stump" 
	"parasol" 
	"mittens" 
	"hockey puck" 
	"beet" 
	"stroller"
)

Print_array() {
	for item in "${random_array[@]}"; do
		echo "$item"
	done
	sleep 1

}
close=1



while [ $close -eq 1 ]; do
	echo "What would you like to do with the array?"
	sleep 1
	echo "1. print all the words"
	echo "2. print a word of your liking"
	echo "3. add an element to the array"
	echo "4. delete an element from the array"
	read -p "what is your choice" choice
	if [ $choice -eq 1 ]; then
		Print_array
	else
		echo "invalid"
		exit
	fi
done

