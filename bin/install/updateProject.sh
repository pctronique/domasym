while read line  
do   
   export $line
done < ${0%/*}/../../.env
#docker exec $NAME_PROJECT_CONTAINER bash -c "cp .env.local.example $FOLDER_PROJECT/.env.local"
#docker exec $NAME_PROJECT_CONTAINER bash -c "chmod 777 $FOLDER_PROJECT/.env.local"
if ! ${0%/*}/project_bash.sh "cd $FOLDER_PROJECT && composer install" ; then
   exit 1
fi
if ! ${0%/*}/project_bash.sh "cd $FOLDER_PROJECT && php bin/console doctrine:database:create" ; then
   exit 0
fi
if ! ${0%/*}/project_bash.sh "cd $FOLDER_PROJECT && php bin/console doctrine:migrations:migrate --dry-run" ; then
   exit 0
fi
