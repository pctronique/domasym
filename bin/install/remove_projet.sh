#!/bin/bash
FOLDER_BASE="${0%/*}/../.."
FOLDER_DOCKER="$FOLDER_BASE/.docker"
FOLDER_DOCKER_CONF="$FOLDER_DOCKER/config"
FOLDER_ENV_DEF="$FOLDER_DOCKER/file_env"

while read line  
do   
   export $line
done < "$FOLDER_ENV_DEF/.env"

rm -f -r "$FOLDER_DOCKER/$DOCKER_FOLDER_PROJECT/Dockerfile"
rm -f -r "$FOLDER_BASE/docker-compose.yml"

rm -f -r "$FOLDER_DOCKER/$DOCKER_FOLDER_PROJECT/php.ini-development"
rm -f -r "$FOLDER_DOCKER/$DOCKER_FOLDER_PROJECT/php.ini"
rm -f -r "$FOLDER_DOCKER/apache/httpd.conf-example"
rm -f -r "$FOLDER_DOCKER/apache/httpd.conf"

if [ -e ${0%/*}/../../.env ]
then

   while read line  
   do   
      export $line
   done < "$FOLDER_BASE/.env"

   rm -f -r "$FOLDER_BASE/project/$FOLDER_PROJECT"
   if ! $FOLDER_BASE/bin/gitignore.sh ; then
      exit 1
   fi

fi

rm -f -r "$FOLDER_BASE/.env"
rm -f -r "$FOLDER_BASE/.env.example"
rm -f -r "$FOLDER_BASE/config"

exit 0
