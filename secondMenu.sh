#!/bin/bash
#echo "the value of x = ${x}"

#echo "your database is : $dataBaseName"
pwd

while true; do
    select data in 'List tables' 'Create tables' 'insert' 'exit'
    do
        case $data in
            'List tables')
                echo "you choosed list tables"
                ls -I "*.metadata" $databases/$dataBaseName
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

