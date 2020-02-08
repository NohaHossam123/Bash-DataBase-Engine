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
    if [ "$(ls -A $databases/$dataBaseName)" ]
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
    read dataBaseName
    if [ -z $dataBaseName ]
    then
      echo "you didn't choose any database....."
    else
    if [ -d $databases/$dataBaseName ]
    then
        export dataBaseName
        export databases
        . ./secondMenu.sh
    else
        echo "$dataBaseName  not found please try again..."
    fi
    fi
}

function createDB {
    if [ -d $databases ]
    then
       #cd $databases
       read -p "enter name of database :" databaseName
    if [ -d "$databases/$databaseName" ] &&  [ -z "$databases/$databaseName" ]
    then
       echo   "$databaseName is exist"
    fi
        
    if [  -z "$databaseName"  ]
    then
       echo "you must enter database name....."
    elif [ -d "$databases/$databaseName" ]
    then
       echo "$databaseName already exists please try again..."
    elif [[ "$databaseName" =~ ^[0-9]+$ ]] #|| [[ "$databaseName" =~ ^[0-9Z]+$ ]]
    then
       echo "sorry,name of database must to be string only.."
    else
       mkdir $databases/$databaseName
    fi
    else
        echo "you didn't in the right path!"
    fi
    pwd
    #cd ..
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
