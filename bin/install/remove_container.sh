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

rm -r -f /tmp/del_container

docker rm -f $NAME_MAIL_DISPLAY_CONTAINER 
docker rm -f $NAME_SGBD_DISPLAY_CONTAINER
docker rm -f $NAME_SGBD_CONTAINER
docker rm -f $NAME_PROJECT_CONTAINER

rm -r -f /tmp/del_container

exit 0
