while read line  
do   
   export $line
done < ${0%/*}/.env
docker exec $NAME_PHP_CONTAINER bash -c "cd projectSymphony && composer install && \
   symfony console doctrine:database:create && symfony console doctrine:migrations:migrate"
