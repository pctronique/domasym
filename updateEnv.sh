while read line  
do   
   export $line
done < ${0%/*}/.env
docker exec $NAME_PHP_CONTAINER bash -c "cp .env.local.example projectSymphony/.env.local"
