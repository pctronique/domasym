#!/bin/bash
FOLDER_BASE="${0%/*}/../.."
FOLDER_DOCKER="$FOLDER_BASE/.docker"
FOLDER_ENV_DEF="$FOLDER_DOCKER/file_env"

while read line  
do   
   if [ ! -z "$line" ]
   then
      export $line
   fi
done < $FOLDER_ENV_DEF/.env

rm -r -f "${0%/*}/../../$PROJECT_TMP_MAIN/env_version.txt"

${0%/*}/recup_version_php.sh
${0%/*}/recup_version_composer.sh

while read line  
do   
   if [ ! -z "$line" ]
   then
      export $line
   fi
done < "${0%/*}/../../$PROJECT_TMP_MAIN/env_version.txt"

if [ ! -f "$PHP_VERSION" ]
then
sed -i "s/FROM php:fpm/FROM php:$PHP_VERSION-fpm/" $FOLDER_DOCKER/$DOCKER_FOLDER_PROJECT/Dockerfile
fi

if [ ! -f "$COMPOSER_VERSION" ]
then
sed -i "s/COPY --from=composer:latest /COPY --from=composer:$COMPOSER_VERSION /" $FOLDER_DOCKER/$DOCKER_FOLDER_PROJECT/Dockerfile
fi
