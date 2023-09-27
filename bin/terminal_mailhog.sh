#!/bin/bash
if ! ${0%/*}/install/message_create_container.sh ; then
   exit 1
fi

while read line  
do   
    if [ ! -z "$line" ]
    then
        export $line
    fi
done < ${0%/*}/../.env
docker exec -it $NAME_MAIL_DISPLAY_CONTAINER bash
