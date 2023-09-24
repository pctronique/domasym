#!/bin/bash
if ! ${0%/*}/message_create_container.sh ; then
   exit 1
fi

FOLDER_BASE="${0%/*}/../.."
FOLDER_DOCKER="$FOLDER_BASE/.docker"
FOLDER_DOCKER_CONF="$FOLDER_DOCKER/config"
FOLDER_ENV_DEF="$FOLDER_DOCKER/file_env"

while read line  
do   
   export $line
done < "$FOLDER_ENV_DEF/.env"

while read line  
do   
   export $line
done < "$FOLDER_BASE/.env"

REAL_PATH_FILE=$(realpath $0)
REAL_PATH="${REAL_PATH_FILE/\/php_create_config.sh/}"

docker exec $NAME_PROJECT_CONTAINER bash -c "cp /usr/local/etc/php/php.ini-development /var/tmp/php"
cp "$REAL_PATH/../../projecttmp/tmp/php/php.ini-development" "$REAL_PATH/../../.docker/$DOCKER_FOLDER_PROJECT/php.ini-development"
cp "$REAL_PATH/../../projecttmp/tmp/php/php.ini-development" "$REAL_PATH/../../.docker/$DOCKER_FOLDER_PROJECT/php.ini"
patch "$REAL_PATH/../../.docker/$DOCKER_FOLDER_PROJECT/php.ini" < "$REAL_PATH/../../.docker/$DOCKER_FOLDER_PROJECT/php_ini.patch"

sed -i "s/#- .\/.docker\/symfony\/php.ini:\/usr\/local\/etc\/php\/conf.d\/php.ini:ro/- .\/.docker\/symfony\/php.ini:\/usr\/local\/etc\/php\/conf.d\/php.ini:ro/" "$REAL_PATH/../../docker-compose.yml" 

exit 0
