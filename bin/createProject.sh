while read line  
do   
   export $line
done < ${0%/*}/../.env
docker exec $NAME_SYMFONY_CONTAINER bash -c "symfony new $FOLDER_PROJECT_SYMFONY --no-git $@"
docker exec $NAME_SYMFONY_CONTAINER bash -c "cp .gitignore $FOLDER_PROJECT_SYMFONY/"
docker exec $NAME_SYMFONY_CONTAINER bash -c "cp .env.local.example $FOLDER_PROJECT_SYMFONY/.env.local"
docker exec $NAME_SYMFONY_CONTAINER bash -c "cd $FOLDER_PROJECT_SYMFONY/ && symfony console doctrine:database:create"
docker exec $NAME_SYMFONY_CONTAINER bash -c "chmod 777 -R $FOLDER_PROJECT_SYMFONY"
