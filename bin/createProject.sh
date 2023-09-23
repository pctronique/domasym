while read line  
do   
   export $line
done < ${0%/*}/../.env
docker exec $NAME_PROJECT_CONTAINER bash -c "symfony new $FOLDER_PROJECT --no-git $@"
${0%/*}/install/in_install.sh
docker exec $NAME_PROJECT_CONTAINER bash -c "cd $FOLDER_PROJECT/ && composer require symfony/mailer"
docker exec $NAME_PROJECT_CONTAINER bash -c "cd $FOLDER_PROJECT/ && composer require symfony/sendgrid-mailer"
docker exec $NAME_PROJECT_CONTAINER bash -c "cd $FOLDER_PROJECT/ && composer require symfony/maker-bundle --dev"
docker exec $NAME_PROJECT_CONTAINER bash -c "cd $FOLDER_PROJECT/ && composer require symfony/orm-pack --dev --with-all-dependencies"
docker exec $NAME_PROJECT_CONTAINER bash -c "cd $FOLDER_PROJECT/ && php bin/console doctrine:database:create"
docker exec $NAME_PROJECT_CONTAINER bash -c "chmod 777 -R $FOLDER_PROJECT"
