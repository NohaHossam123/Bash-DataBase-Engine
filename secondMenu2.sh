#!/bin/bash
while true; do
    select data in 'List tables' 'Create tables' 'insert' 'delete' 'exit'
    do
        case $data in
            'List tables')
                echo "you choosed list tables"
                tables=`ls -I "*.metadata" $databases/$dataBaseName`
                echo "$tables"
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

