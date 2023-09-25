#!/bin/bash
if ! ${0%/*}/install/message_create_container.sh ; then
   exit 1
fi

while read line  
do   
   export $line
done < ${0%/*}/../.env

if ! ${0%/*}/install/php_create_config.sh ; then
  exit 1
fi

docker exec $NAME_PROJECT_CONTAINER bash -c "symfony new $FOLDER_PROJECT --no-git $@"
docker exec $NAME_PROJECT_CONTAINER bash -c "chmod 777 -R $FOLDER_PROJECT"

if ! ${0%/*}/install/in_install.sh ; then
  exit 1
fi

docker exec $NAME_PROJECT_CONTAINER bash -c "chmod 777 -R $FOLDER_PROJECT"

cd ${0%/*}/../
if ! docker compose up -d ; then
  exit 1
fi

docker exec $NAME_PROJECT_CONTAINER bash -c "cd $FOLDER_PROJECT/ && composer require symfony/mailer"
docker exec $NAME_PROJECT_CONTAINER bash -c "cd $FOLDER_PROJECT/ && composer require symfony/sendgrid-mailer"
docker exec $NAME_PROJECT_CONTAINER bash -c "cd $FOLDER_PROJECT/ && composer require symfony/maker-bundle --dev"
docker exec $NAME_PROJECT_CONTAINER bash -c "cd $FOLDER_PROJECT/ && composer require symfony/orm-pack --dev --with-all-dependencies"
#docker exec $NAME_PROJECT_CONTAINER bash -c "cd $FOLDER_PROJECT/ && php bin/console doctrine:database:create"
