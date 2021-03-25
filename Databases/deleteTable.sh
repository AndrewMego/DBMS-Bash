#!/bin/bash

echo "Enter Table Name"
read TableName 
if [ -f  "$currDB/Data/$TableName.json" ] && [ -f  "$currDB/Metadata/$TableName.json" ]; then 
    rm -r $currDB/Data/$TableName.json
    rm -r $currDB/Metadata/$TableName.json
    echo "$TableName Table  deleted Successfully"
  else 
    echo "No such Table"
fi









