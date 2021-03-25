#!/bin/bash

options=("Show Exist Databases" "Create New Database" "Use Exist Database" "Delete Database" "Quit")
while [[ "$option" != "Quit" ]] 
do
	select option in "${options[@]}"
	do
		case $option in
			"Show Exist Databases") . ./showDB.sh; break ;;
			"Create New Database"). ./createDB.sh; break ;;
			"Use Exist Database") . ./useDB.sh break ;;
			"Delete Database") . ./deleteDB.sh; break ;;
			"Quit")  break; exit $?;;
			*) echo "Invalid option $REPLY";;
		esac
	done
done
