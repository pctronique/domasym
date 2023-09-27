while read line  
do   
   if [ ! -z "$line" ]
   then
      export $line
   fi
done < ${0%/*}/.env
cd /home/project/$FOLDER_PROJECT
symfony server:$1
