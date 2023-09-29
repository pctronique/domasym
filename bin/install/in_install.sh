#!/bin/bash
if ! ${0%/*}/message_create_container.sh ; then
  exit 1
fi

while read line  
do   
   if [ ! -z "$line" ]
   then
      export $line
   fi
done < ${0%/*}/../../.env

LINE1="- .\/config\/.env.local:\/home\/project\/www\/.env.local:ro"
LINE1_REPLACE="- .\/config\/.env.local:\/home\/project\/$FOLDER_PROJECT\/.env.local:ro"
DESACTIVE="#"
FILE="${0%/*}/../../docker-compose.yml"

cp ${0%/*}/../../.docker/config/.gitignore ${0%/*}/../../project/www/.gitignore

sed -i "s/$DESACTIVE$LINE1/$LINE1_REPLACE/" $FILE

#cd ${0%/*}/../../
#docker compose up -d
