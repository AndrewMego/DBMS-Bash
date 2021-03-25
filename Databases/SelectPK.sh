#!/bin/bash

echo "Enter Table Name :"
read TableName 
if [ -f "$currDB/Data/$TableName" ] && [ -f  "$currDB/Metadata/$TableName" ]; then 
echo "Enter PK Column Name"
read ColumnPK
if grep -q $ColumnPK  "$currDB/Metadata/$TableName" 
then
Res=$(grep  $ColumnPK  "$currDB/Metadata/$TableName"  | awk -F: '{ if($3 == "yes") {print "1"} else {print "0"}}')
ColumnNumMetadata=$(grep -n $ColumnPK  "$currDB/Metadata/$TableName" | awk -F: '{print $1}' )
if [ $Res == "1" ];
then
echo "Enter PK Value"
read Rpk  
grep  $Rpk $currDB/Data/$TableName >> file.temp
ColumnNumData=$(awk -v rk="$Rpk" -F: '{ for (i=0; i<=NF; i++){if ($i==rk){print i}}}' $(pwd)/file.temp)
rm -f file.temp
if [ $ColumnNumMetadata == $ColumnNumData ];  
then  
var1=$(grep -ow $Rpk $currDB/Data/$TableName)
grep -w $Rpk $currDB/Data/$TableName  | awk -F: '{print $0}'
else
echo "No such value in PK column" 
fi

else 
echo "Not PK"
fi

else 
echo "$ColumnPK does not exist"
fi

else 
echo "No such Table"
fi
