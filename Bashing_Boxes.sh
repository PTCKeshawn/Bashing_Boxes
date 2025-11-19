#!/bin/bash

#array list
close=1
Prompt_for_list(){
	read -p "Would you like to:
	 1) Generate a new list of your choice
	 2) Start with a default array
	 3) Load a previously saved array
	 : " list_choice

	 case $list_choice in
	 	1)  read -p "how many words do you want:  " size
	 		echo " searching for word bank..."
	 		check_for_saved_array
			random_array=($(shuf -n "$size" data/'list random generator'/warehouse_of_objects.txt))
			echo "Generated random word array:"
			printf "%s\n" "${random_array[@]}"
	 		;;
	 	2)default_array=(
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
		random_array=("${default_array[@]}")
		echo "Loaded default array."
		sleep 1
		echo "your array is : "
		printf '%s\n' "${random_array[@]}"
	 		;;
	 	3)	load_array_to_use
	 		set_array

	 		;;
	 	*)  echo "Invalid selection. Please enter 1 or 2."
	 		sleep 1
            Prompt_for_list 
	 		;;
	 esac
}
load_array_to_use(){
	if compgen -G "data/*.txt" > /dev/null; then
	        echo "your saved arrays: "
	        ls data/*.txt | xargs -n 1 basename
	        sleep 1
	    else
	        echo "No saved arrays found."
	        sleep 1
	        Prompt_for_list
	        return
	    fi
}
set_array(){
	read -p "Enter the name of the array to load (without .txt): " load_name

            if [[ -f "data/${load_name}.txt" ]]; then
                mapfile -t random_array < "data/${load_name}.txt"
                echo "Loaded array: $load_name"
                printf "%s\n" "${random_array[@]}"
            else
                echo "File not found!"
                Prompt_for_list
                return
            fi
}

check_for_saved_array(){
	if [ ! -f data/'list random generator'/warehouse_of_objects.txt ]; then
   		echo "Error: word bank not found not found."
    	return
	fi
}

#prints the whole array
Print_array() {
	for item in "${random_array[@]}"; do
		echo "$item"
	done
	sleep 1

}

#prints out a single element in the array
print_single_word(){
	
	echo "enter the index of the object you want to print."
	read -p "tip: The first element on the list is counted as 0." index
	
	#this line means if the user put a number that is 0 or higher, and smaller than the number of items in the array, then do the following
	if [ "$index" -ge 0 ] && [ "$index" -lt "${#random_array[@]}" ]; then
		echo "You chose: ${random_array[$index]}"
	else
		echo "invalid"
	fi
sleep 1
}

#adds element to the array
add_item(){
	read -p "what word do you want to add" word
	read -p "where do you want to add the item in the array?" pos
	 #checks if index number user gave is in the array
	 if [ "$pos" -ge 0 ] && [ "$pos" -le "${#random_array[@]}" ]; then
        # Splits the array to add the word
       random_array=("${random_array[@]:0:$pos}" "$word" "${random_array[@]:$pos}")
        echo "Array after insertion: ${random_array[@]}"
    else
        echo "Invalid position."
    fi
}

#deletes an element from the array
delete_item(){
	echo "enter the index of the word you want to delete"	
	read -p "tip: The first word oh array starts with and index of 0 " delete
	if [ "$delete" -ge 0 ] && [ "$delete" -lt "${#random_array[@]}" ]; then
		unset 'random_array[delete]'
		random_array=("${random_array[@]}")
		echo "Array after deletion : ${random_array[@]}"
	else
		echo "invalid index"
	fi
}

#saves the array to a file that is rereadable
save_array(){
	read -p "what would you like to name the file?" new_file
	printf "%s\n" "${random_array[@]}" > "data/${new_file}.txt"
	echo "saved as $new_file.txt"
	sleep 1
}

#loads the saved array
load_array(){
	read -p "Which file would you like to view? " file_to_view
		if [[ -f "data/${file_to_view}.txt" ]]; then
	    	echo "Contents of ${file_to_view}:"
	    	cat "data/${file_to_view}.txt"
	    	sleep 2
		else
	    	echo "File not found!"
		fi

}

#lists the saved arrays you have saved
List_saved_arrays() {
    echo "arrays:"
    if compgen -G "data/*.txt" > /dev/null; then
        ls data/*.txt | xargs -n 1 basename
        sleep 1
    else
        echo "No saved arrays found."
        sleep 1
    fi
}

#deletes a saved array
Delete_array() {
    read -p "Which file would you like to delete? " file_to_delete
    if [[ -f "data/${file_to_delete}.txt" ]]; then
        rm "data/${file_to_delete}.txt"
        echo "${file_to_delete}.txt deleted."
        sleep 1
    else
        echo "File not found!"
        sleep 1
    fi
}

#exits the code
exiting(){
	read -p "would you like to save before exiting? (y/n):" exit_read
	case $exit_read in
		"y"|"Y") save_array 
			 sleep 1
			 close=0
			;;
		"n"|"N") echo "exiting..."
			 sleep 1
			 close=0
			 ;;
		*) echo -e "
			That was an invalid selection. 
			Please try again."
			sleep 2
			display_main_menu
			;;
	esac
}

#first welcone message
echo "Welcome to Keshawn's array customizer!"
sleep 1

#displays the options user has
display_main_menu(){
	echo -e "
		| Main Menu
		|-----------
		| 1) print all the words
		| 2) print a word of your liking
		| 3) add an element to the array
		| 4) delete an element from the array
		| 5) save your array
		| 6) load your array
		| 7) list your saved arrays
		| 8) delete your saved array
		| 9) exit
		"
	read -p "what is your choice: " choice
	check_user_input

}

#checks user input from 'display_main_menu'
check_user_input(){
		case $choice in
		1) Print_array
			;;
		2) print_single_word
			;;
		3) add_item
			;;
		4) delete_item
			;;
		5) save_array
			;;
		6) load_array
			;;
		7) List_saved_arrays
			;;
		8) Delete_array
			;;
		9) exiting
			;;
		*) 
			echo -e "
			That was an invalid selection. 
			Please try again."
			sleep 2
			display_main_menu
			;;
	esac
}

Prompt_for_list

while [ $close -eq 1 ]; do
    display_main_menu
done


