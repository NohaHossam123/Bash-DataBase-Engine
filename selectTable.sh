function selectFromTable {
    echo "Enter the table you want to display it : "
    read -e tableIsSelect
    if [ -z $tableIsSelect ]
    then
        echo "you must to enter the name of the table"
    else
        if [[ -f  "$databases/$dataBaseName/$tableIsSelect" ]]
        then
            awk -F, '{if(NR!=1){print$1}}' $databases/$dataBaseName/$tableIsSelect.metadata | tr ['\n'] [' ']
            echo $'\n'
            cat $databases/$dataBaseName/$tableIsSelect | tr [','] [' ']
        else
            echo "the table you have entered does not exists please try again..."
        fi
    fi
}

function selectFromTableByValue {
    echo "enter a table name"
    read -e tableName
    if [[ -z "$tableName" ]]
    then
        echo "you must enter a table..."
    elif [[ -f  "$databases/$dataBaseName/$tableName" ]]
    then
        echo "enter a coulmn name : "
        read -e col
        colIndex=$(awk  -F, ' { if($1~/'$col'/) print NR-1} ' $databases/$dataBaseName/$tableName.metadata)
        
        if [[ "$colIndex" =~ ^[0-9]+$ ]]
        then
            let colIndex+=1
            coulmnDataType=`sed -n "$colIndex"p $databases/$dataBaseName/$tableName.metadata  | cut -d, -f2`
            let colIndex-=1
            echo "enter a value "
            read -e value
            if  [[ "$value" =~ ^[0-9]+$ ]] && [[ $coulmnDataType == "number" ]]
            then
                awk -F, '{if(NR!=1){print$1}}' $databases/$dataBaseName/$tableName.metadata | tr ['\n'] [' ']
                echo $'\n'
                awk -F, ' BEGIN{} { if ($'$colIndex' ~ /^'$value'$/) print $0,"\n"}' $databases/$dataBaseName/$tableName | cat | tr [','] [' ']
            elif [[ "$value" =~ ^[a-zA-Z0-9]+$ ]] && [[ $coulmnDataType == "string" ]]
            then
                awk -F, '{if(NR!=1){print$1}}' $databases/$dataBaseName/$tableName.metadata | tr ['\n'] [' ']
                echo $'\n'
                awk -F, ' BEGIN{} { if ($'$colIndex' ~ /^'$value'$/) print $0,"\n"}' $databases/$dataBaseName/$tableName | cat | tr [','] [' ']
            else
                echo "the value you entered does not match the coulmn datatype..."
            fi
            
        else
            echo "coulmn does not exist..."
        fi
    else
        echo "table does not exist..."
    fi
}





select data in 'select all data' 'select by a value'
do
    case $data in
        'select all data')
            selectFromTable
            break;
        ;;
        'select by a value')
            selectFromTableByValue
            break;
        ;;
        *)
            echo "unknown choice..."
            break;
    esac
done