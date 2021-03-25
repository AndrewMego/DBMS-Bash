#!/bin/bash

DIR="$(pwd)/$currDB/Data"
if [ -d "$DIR" ] && [ "$(ls -A $DIR)" ]; then
   echo "Available tables"
  ls $DIR
else 
    echo "No tables to show"
fi


