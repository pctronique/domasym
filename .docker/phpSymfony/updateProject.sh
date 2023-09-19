while read line  
do   
   export $line
done < ${0%/*}/.env
cd /home/project/$FOLDER_PROJECT_SYMFONY
symfony server:start >> ../../projecttmp/logs/symfony/symfony_out.log 2>> ../../projecttmp/logs/symfony/symfony_error.log & 
