function selectFromTable {
	echo "Enter the table you want to display it : "
        read tableIsSelect
        if [ -z $tableIsSelect ]
	then
        echo "you must to enter the name of the table"
        else
          if [[ -f  "$databases/$dataBaseName/$tableIsSelect" ]]
          then
          awk -F, '{if(NR!=1){print$1}}' $databases/$dataBaseName/$tableIsSelect.metadata | tr ['\n'] ['\t']
          echo $'\n'
          cat $databases/$dataBaseName/$tableIsSelect | tr [','] [' '] 
          else
          echo "the table you have entered does not exists please try again..."
          fi
        fi
	

}

