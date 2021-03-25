#! /bin/bash
read -p "Enter column name: " colName;

colNames=($(awk -F: '{print $1}' $currDB/Metadata/$tableName))

colFlag=1  

for i in "${!colNames[@]}"
do 
    if [[ $colName == "${colNames[$i]}" ]]; then
        colFlag=0  
        colNum=$(($i+1));  
    fi   
done

if [[ $colFlag == 0 ]]; then


    cut -d':' --complement -f$colNum $currDB/Data/$tableName > $currDB/Data/$tableName.json
    mv $currDB/Data/$tableName.jsono $currDB/Data/$tableName

    sed -i "$colNum"d $currDB/Metadata/$tableName
else
    echo "ERROR:In-valid column name.";
fi
