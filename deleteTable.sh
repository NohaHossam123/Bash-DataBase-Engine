function deleteFromTable {
    echo "Enter the table : "
    read -e tableName
    if [ -z $tableName ]
    then
        echo "no enter table to delete..."
    else
        if [[ -f "$databases/$dataBaseName/$tableName" ]]
        then
            echo "Enter the number of deleted row : "
            read -e NoOfDeletedRow
            if [ -z $NoOfDeletedRow ]
            then
                echo "you must to enter which number of row you want to delete it"
            else
                rowsNo=`awk 'END {print NR}' $databases/$dataBaseName/$tableName`
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


function deleteFromTableByValue {
    echo "enter a table name"
    read -e tableName
    if [[ -z $tableName ]]
    then
        echo "you must enter a table name"
    elif [[ -f  "$databases/$dataBaseName/$tableName" ]]
    then
        echo "enter a coulmn name : "
        read -e col
        if [[ -z $col ]]
        then
            echo "you must enter a coulmn name..."
        else
            if [[ "$colIndex" =~ ^[0-9]+$ ]]
            then
                let colIndex+=1
                coulmnDataType=`sed -n "$colIndex"p $databases/$dataBaseName/$tableName.metadata  | cut -d, -f2`
                let colIndex-=1
                echo "enter a value "
                read -e value
                if  [[ "$value" =~ ^[0-9]+$ ]] && [[ $coulmnDataType == "number" ]]
                then
                    newData=`awk -F, '{ if ($'$colIndex' !~ /^'$value'$/) print $0}' $databases/$dataBaseName/$tableName`
                    echo "$newData" > $databases/$dataBaseName/$tableName
                elif [[ "$value" =~ ^[a-zA-Z0-9]+$ ]] && [[ $coulmnDataType == "string" ]]
                then
                    newData=`awk -F, '{ if ($'$colIndex' !~ /^'$value'$/) print $0}' $databases/$dataBaseName/$tableName`
                    echo "$newData" > $databases/$dataBaseName/$tableName
                else
                    echo "the value you entered does not match the coulmn datatype..."
                fi
                
            else
                echo "coulmn does not exist..."
            fi
        fi
        colIndex=$(awk  -F, ' { if($1~/^'$col'$/) print NR-1} ' $databases/$dataBaseName/$tableName.metadata)
        
    else
        echo "table does not exist..."
    fi
}


select data in 'delete by row number' 'delete by a value'
do
    case $data in
        'delete by row number')
            deleteFromTable
            break;
        ;;
        'delete by a value')
            deleteFromTableByValue
            break;
        ;;
        *)
            echo "unknown choice..."
            break;
    esac
done

