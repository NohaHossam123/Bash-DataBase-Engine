function deleteFromTable {
	echo "Enter the table : "
	read tableName
	if [ -z $tableName ]
	then
	  echo "you must to enter name of table"
	else
	if [[ -f "$databases/$dataBaseName/$tableName" ]]
	then
	  echo "Enter the number of deleted row : "
	  read NoOfDeletedRow
	if [ -z $NoOfDeletedRow ]
	then
	  echo "you must to enter which number of row you want to delete it"
	else
          rowsNo=`awk 'END {print NR}' $databases/$dataBaseName/$tableName`
          echo "$rowsNo"
	if [[ $NoOfDeletedRow -gt $rowsNo ]]
        then 
          echo "$NoOfDeletedRow is greater than number of rows"
        else
          rowAfterDeleted=`sed "$NoOfDeletedRow"d $databases/$dataBaseName/$tableName`
          echo "$rowAfterDeleted" > $databases/$dataBaseName/$tableName
	fi
	fi
	else
	 echo "the table you have entered does not exists please try again..."
        fi
	fi
}
