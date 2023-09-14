while read line  
do   
   export $line
done < ${0%/*}/.env
docker exec $NAME_PHP_CONTAINER bash -c "cd projectSymphony && \
   symfony server:start >> ../../projecttmp/logs/symfony/symfony_out.log \
      2>> ../../projecttmp/logs/symfony/symfony_error.log" &
