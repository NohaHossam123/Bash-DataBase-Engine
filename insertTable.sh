function insertIntoTable {
    found=0
    echo "enter the name of the table "
    read tableName
    if [[ -f "$databases/$dataBaseName/$tableName" ]]
    then
        numOfCoulmns=`head -n1 $databases/$dataBaseName/$tableName.metadata  | cut -d, -f2`
        #echo "number of coulmns = $numOfCoulmns"
        curruntCoulmnValue=""
        insertFlag=1
        for ((i=2; i <= $numOfCoulmns+1; i++)) do
            curruntCoulmn=`sed -n "$i"p $databases/$dataBaseName/$tableName.metadata  | cut -d, -f1`
            coulmnDataType=`sed -n "$i"p $databases/$dataBaseName/$tableName.metadata  | cut -d, -f2`
            echo "enter the value of $curruntCoulmn"
            read curruntValue
            if [[ "$curruntValue" =~ [,] ]]
            then
            echo "values can not contain a comma..."
            break;
            elif  [[ "$curruntValue" =~ ^[0-9]+$ ]] && [[ $coulmnDataType == "number" ]]
            then
                echo ""
            elif [[ "$curruntValue" =~ [[:alnum:]] ]] && [[ $coulmnDataType == "string" ]]
            then
                echo ""
            else
                echo "the value you entered does not match the coulmn datatype..."
                insertFlag=0
                break;
            fi
            
            curruntCoulmnValue+="$curruntValue,"
            
        done
        if [[ $insertFlag == 1 ]]
        then
            echo $curruntCoulmnValue >> $databases/$dataBaseName/$tableName
        fi
    else
        echo "the table you have entered does not exists please try again..."
    fi
    
    
}