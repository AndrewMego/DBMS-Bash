#!/bin/bash

function validateTableName(){
    valid=0
    IFS=' ' read -r -a array <<< $1;
    if (( ${#array[@]} > 1 )); then 
        echo "ERROR: Table name can not contain spaces.";
        valid=1;
    fi

    if (( ${#array[@]} == 0 )); then 
        echo "ERROR: Table name can not be empty.";
        valid=1; 
    fi

    first="${array[0]:0:1}"
    if [[ $first =~ [0-9] ]]; then
        echo "ERROR: Table name can not begin with number.";
        valid=1;
    fi


    if [[ "$1" =~ [A-Za-z] ]]; then
        echo "Valid table name";
    else
        echo "ERROR: Table name must contain at least one letter." >> log.out;
        valid=1; 
    fi

    echo $valid;
}


function tableExists(){
    currDB=$1;
    tableName=$2;

    valid=0     ;

    if [[ -f Databases/$currDB/Data/$tableName ]]; then
        echo "ERROR: Table already exists.";
        valid=1; 
    fi

    echo $valid;
}


function validateColumnName(){
    valid=0     
    IFS=' ' read -r -a array <<< $1;
    if (( ${#array[@]} > 1 )); then 
        echo "ERROR: Column name can not contain spaces.";
        valid=1; #false
    fi

    if (( ${#array[@]} == 0 )); then 
        echo "ERROR: Column name can not be empty.";
        valid=1
    fi

    first="${array[0]:0:1}"
    if [[ $first =~ [0-9] ]]; then
        echo "ERROR: Column name can not begin with number.";
        valid=1;
    fi


    if [[ "$1" =~ [A-Za-z] ]]; then
        echo "Valid Column name";
    else
        echo "ERROR: Column name must contain at least one letter.";
        valid=1;  
    fi

    echo $valid;
}


function createColumns(){
    read -p "Enter number of columns: " numCols;
     
    for (( i=0; i<$numCols; i++ ))
    do
        colMetadata="";
        read -p "Enter column name: " colName;
        nameFlag=$(validateColumnName "$colName");
        if [[ $nameFlag == 0 ]]; then
            colMetadata="$colName";
            # select column datatype (string, number)
            read -p "Choose column's datatype String(s) Number(n): (s/n)" colDataType;
            if [[ $colDataType == "s" || $colDataType == "S" ]]; then
                colMetadata="$colMetadata:string";
            elif [[ $colDataType == "n" || $colDataType == "N" ]]; then
                colMetadata="$colMetadata:number";
            fi
            # Is it Primary-Key (PK): (y/n):
            read -p "Is it Primary-Key (PK): (y/n)" pk;
            if [[ $pk == "y" || $pk == "Y" ]]; then
                colMetadata="$colMetadata:yes";
            elif [[ $pk == "n" || $pk == "N" ]]; then
                colMetadata="$colMetadata:no";
            fi

          	echo $colMetadata >> "$currDB/Metadata/$tableName.json";
            
        else
            echo "In-valid column name";
        fi
    done
}

read -p "Enter table name: " tableName;

nameFlag=$(validateTableName "$tableName");
tableExistsFlag=$(tableExists "$currDB" "$tableName");


if [ $nameFlag == 0 ] && [ $tableExistsFlag == 0 ]; then
    if touch "$currDB/Data/$tableName.json"; then
        echo "Empty table created sucessfully." ;
        # create Metadata/tableName.json
        if touch "$currDB/Metadata/$tableName.json"; then
            echo "Metadata file created sucessfully.";
        else
            echo "Falied to create metadata.";
        fi

        if createColumns; then
            echo "Table $tableName created sucessfully.";
            cat "$currDB/Metadata/$tableName.json";
        else
            echo "ERROR: Failed to create $tableName."
        fi
    else
        echo "Falied to create table.";
    fi

else
    echo "Can not create table.";
fi
