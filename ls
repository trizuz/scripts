#!/bin/bash
# A version of ls (list directory contents) that hides files of a directory listed in a .hidden file
# Set -a or --all to show hidden files

# TODO look for a global .hidden file in home dir or file defined by a ENV variable

show_hidden=0

# Test if -a or --all option is set. Store all ls options
for i; do
	if [[ "$i" =~ ^-([b-z]|[A-Z])*a([b-z]|[A-Z])* ]] || [ $i == "--all" ]; then
		show_hidden=1
	fi

	options+="$i "
done

# If .hidden file exists and --all option is not set append ignore options
if [ -f ".hidden" ] && [ "$show_hidden" -eq "0" ]; then
	for line in $(cat .hidden); do
		options+="--ignore=$line "
	done
fi 

ls "--color=tty" $options
exit $?
