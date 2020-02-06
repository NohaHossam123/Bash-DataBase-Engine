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
    #pwd
    if [ -d $databases ]
    then
        ls $databases
    else
        echo "you don't have any file for databases!"
    fi
}

function connectToDataBase {
    echo "please choose a database to connect : "
    read dataBaseName
    if [ -d $databases/$dataBaseName ]
    then
        export dataBaseName
        export databases
        . ./s2.sh
    else
        echo "database not found please try again..."
    fi
}

function createDB {
    #pwd
    if [ -d $databases ]
    then
        cd $databases
        read -p "enter name of database :" databaseName
        if [ -d "$databaseName" ] &&  [ -z "$databaseName" ]
        then
            echo   "$databaseName is exist"
        fi
        
        if [  -z "$databaseName"  ]
        then
            echo "you must enter database name!"
        elif [ -d "$databaseName" ]
        then
            echo "$databaseName already exists please try again..."
        else
            mkdir $databaseName
        fi
    else
        echo "you didn't in the right path!"
    fi
    pwd
    cd ..
}



while (true)
do
    select data in 'List database' 'Create database' 'Connect database' 'Exit'
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
                #pwd
                connectToDataBase
                
                break
            ;;
            
            'Exit')
                break 2
            ;;
        esac
    done
done