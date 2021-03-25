#!/bin/bash

echo "Enter Table Name :"
read TableName

if [ -f "$currDB/Data/$TableName" ] && [ -f  "$currDB/Metadata/$TableName" ]; then 

    awk -F: 'BEGIN { ORS=":" }; { print $1 }' $currDB/Metadata/$TableName
    printf "\n"
    cat  $currDB/Data/$TableName 
    else 
    echo "No such Table"
fi

