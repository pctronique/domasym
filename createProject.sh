while read line  
do   
   export $line
done < ${0%/*}/.env
docker exec $NAME_PHP_CONTAINER bash -c "symfony new projectSymphony --no-git && \
   cp .gitignore projectSymphony/ && symfony console doctrine:database:create"
