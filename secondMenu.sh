#!/bin/bash
#echo "the value of x = ${x}"

#echo "your database is : $dataBaseName"
pwd

while true; do
    select data in 'List tables' 'Create tables' 'insert' 'delete' 'select' 'exit'
    do
        case $data in
            'List tables')
		if [ "$(ls -A $databases/$dataBaseName)" ]
		then
		   echo "you choosed list tables"
                   ls -I "*.metadata" $databases/$dataBaseName
		else
		  echo "there aren't any tables to show......"
		fi
                break;
            ;;
            
            'Create tables')
                . "createTable.sh"
                createTable
                break;
            ;;
            'insert')
                . "insertTable.sh"
                insertIntoTable
                break;
            ;;
            'delete')
   	       . "deleteTable.sh"
               deleteFromTable
               break;
            ;;
	    'select')
               . "selectTable.sh"
               selectFromTable
               break;
            ;;
            'exit')
                break 2;
            ;;
            *)
                echo "unknown opration choosed..."
                break;
            ;;
        esac
    done
done

