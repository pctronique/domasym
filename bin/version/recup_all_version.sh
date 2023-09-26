#!/bin/bash
FOLDER_BASE="${0%/*}/../.."
FOLDER_DOCKER="$FOLDER_BASE/.docker"
FOLDER_ENV_DEF="$FOLDER_DOCKER/file_env"

while read line  
do   
   export $line
done < $FOLDER_ENV_DEF/.env

${0%/*}/recup_version_php.sh
${0%/*}/recup_version_composer.sh

while read line  
do   
   export $line
done < "${0%/*}/../../$PROJECT_TMP_MAIN/env_version.txt"

sed -i "s/FROM php:fpm/FROM php:$NODEJS_VERSION-fpm/" $FOLDER_DOCKER/$DOCKER_FOLDER_PROJECT/Dockerfile
sed -i "s/RUN npm install -y --no-install-recommends pm2 -g/RUN npm install -y --no-install-recommends pm2@$PM2_VERSION -g/" $FOLDER_DOCKER/$DOCKER_FOLDER_PROJECT/Dockerfile
sed -i "s/COPY --from=composer:latest /COPY --from=composer:$COMPOSER_VERSION /" $FOLDER_DOCKER/$DOCKER_FOLDER_PROJECT/Dockerfile
