#!/bin/bash 


user=`whoami`
databases="/home/$user/Desktop/databases"

if [ -d $databases ]
then
    echo "database directory found..."
else
    echo "database directory created..."
    mkdir $databases
fi


function listDB {
    if [ -d $databases ]
    then
        #if [ -d $databases/$dataBaseName ]
        if [ "$(ls -A $databases)" ]
        then
            ls $databases
        else
            echo "there aren't any databases to show..."
        fi
    else
        echo "you don't have any file for databases!"
    fi
}

function connectToDataBase {
    echo "please choose a database to connect : "
    read -e dataBaseName
    if [[ -z $dataBaseName ]]
    then
        echo "you must enter a databasename"
    elif [ -d $databases/$dataBaseName ]
    then
        export dataBaseName
        export databases
        . ./secondMenu.sh
    else
        echo "database not found please try again..."
    fi
}

function createDB {
    if [ -d $databases ]
    then
        read -e -p "enter name of database :" databaseName
        
        if [[ $databaseName =~ ^[a-zA-Z0-9]+$ ]]
        then
            if [[ "$databaseName" =~ ^[0-9] ]] || [[ "$databaseName" =~ [,] ]]
            then
                echo "database Name must start with characters and does not contain a comma..."
            elif [ -d "$databases/$databaseName" ] &&  [ -z "$databases/$databaseName" ]
            then
                echo   "$databaseName is exist"
            else
                if [  -z "$databaseName"  ]
                then
                    echo "you must enter database name!"
                elif [ -d "$databases/$databaseName" ]
                then
                    echo "$databaseName already exists please try again..."
                else
                    mkdir $databases/$databaseName
                fi
            fi
        else
            echo "invalid database name"
        fi
        
        
    else
        echo "you didn't in the right path!"
    fi
}

function dropDatabase {
    if [ -d $databases ]
    then
        cd $databases
        echo "enter the database name : "
        read -e databaseName
        if [[ -z $databaseName ]]
        then
            echo "you must enter a database name"
        elif [ -d $databaseName ]
        then
            rm -r $databaseName
            echo "database $databaseName deleted..."
            cd -
        else
            echo "database does not exist..."
        fi
    else
        echo "you didn't in the right path!"
    fi
}

while (true)
do
    select data in 'List database' 'Create database' 'Connect database' 'drop database' 'Exit'
    do
        case $data in
            'List database')
                listDB
                break
            ;;
            'Create database')
                createDB
                break
            ;;
            'Connect database')
                connectToDataBase
                break
            ;;
            'drop database')
                dropDatabase
                break
            ;;
            
            'Exit')
                break 2
            ;;
            *)
                echo "unknown opration choosed..."
                break;
            ;;
        esac
    done
done