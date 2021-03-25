#!/bin/bash

echo "Enter Database Name: ";
read newDB;
if mkdir ./$newDB ; then
    mkdir ./$newDB/Data;
    mkdir ./$newDB/Metadata;
    printf "$newDB created succesfully.\n";
else
    printf "Can not create $newDB\n";
fi
