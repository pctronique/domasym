while read line  
do   
   if [ ! -z "$line" ]
   then
      export $line
   fi
done < ${0%/*}/.env
cd /home/project/$FOLDER_PROJECT
symfony server:$1 --no-tls -d >> /var/log/symfony/symfony_out.log 2>> /var/log/symfony/symfony_error.log
