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
print_single_word(){
	
	echo "enter the index of the object you want to print."
	read -p "hint: The first element on the list is counted as 0." index
#this line means if the user put a number that is 0 or higher, and smaller than the number of items in the array, then do the following
	if [ "$index" -ge 0 ] && [ "$index" -lt "${#random_array[@]}" ]; then
		echo "You chose: ${random_array[$index]}"
	else
		echo "invalid"
	fi
sleep 1
}

add_item(){
	read -p "what word do you want to add" word
	read -p "where do you want to add the item in the array?" pos
	 if [ "$pos" -ge 0 ] && [ "$pos" -le "${#random_array[@]}" ]; then
        # Splits the array to add the word
       random_array=("${random_array[@]:0:$pos}" "$word" "${random_array[@]:$pos}")
        echo "Array after insertion: ${random_array[@]}"
    else
        echo "Invalid position."
    fi
}

close=1



while [ $close -eq 1 ]; do
	echo "What would you like to do with the array?"
	sleep 1
	echo "1. print all the words"
	echo "2. print a word of your liking"
	echo "3. add an element to the array"
	echo "4. delete an element from the array"
	echo "5. exit"
	read -p "what is your choice" choice
	if [ $choice -eq 1 ]; then
		Print_array
	elif [ $choice -eq 2 ]; then
		print_single_word
	
	elif [ $choice -eq 3 ]; then
		add_item	
	else
		echo "invalid"
		exit
	fi

done

