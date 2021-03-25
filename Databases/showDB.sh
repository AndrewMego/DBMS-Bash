#!/bin/bash
DIR="$(pwd)"
if [ -d "$DIR" ] && [ "$(ls -A $DIR)" ]; then
   echo "Available Databases"
    ls -d */
else 
    echo "No Databases to show"
fi
