#!/bin/bash

echo "DB:$currDB, table:$tableName" 

read -p "Enter column name: " colName;


colNames=($(awk -F: '{print $1}' $currDB/Metadata/$tableName))


colFlag=1 

for i in "${!colNames[@]}"
do 
    if [[ $colName == "${colNames[$i]}" ]]; then
        colFlag=0   #true
        colNum=$(($i+1));
    fi   
done

if [[ $colFlag == 0 ]]; then

    read -p "Enter value to delete record with: " value;

    echo "colNum = $colNum"

    recordNum=($(awk -v varCol="$colNum" -v varValue="$value" -F: '{if ($varCol == varValue) {print FNR}}' "$currDB/Data/$tableName"))

    counter=0

    for i in "${!recordNum[@]}"
    do
        index=${recordNum[$i]}
        index=$(($index-$counter))
        echo "index:$index"
        sed -i "$index"d $currDB/Data/$tableName

        counter=$(($counter+1))
    done
    echo $recordNum
else
    echo "In-valid column name";
fi



