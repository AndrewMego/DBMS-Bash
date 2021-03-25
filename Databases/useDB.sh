#!/bin/bash

useDB_main_menu(){
    options=("Show Tables" "Create New Table" "Insert Into Table" "Delete Table" "Update Table" "UseTable" "Return To Main Menu");
     while [[ "$option" != "Return To Main Menu" ]]
    do
    select option in "${options[@]}"
    do
        case $option in
            "Show Tables") . ./showTables.sh;break ;;
            "Create New Table") . ./createTable.sh; break;;
            "Insert Into Table") . ./insertIntoTable.sh; break;;
            "Delete Table") . ./deleteTable.sh; break ;;
            "Update Table") . ./updateTable.sh; break ;;
            "UseTable") . ./UseTable.sh; break ;;
            "Return To Main Menu") . ./start_DBMS.sh; exit $? ;;
            *) echo "Invalid option $REPLY";;
        esac
    done
    done
}

echo "Enter database name: "
read currDB;

if [[ -d $currDB ]]
then
    export  currDB=$currDB;
    echo "$currDB is selected.";
    useDB_main_menu;
else
    echo "Database does not exist.";
    . ./start_DBMS.sh

fi
