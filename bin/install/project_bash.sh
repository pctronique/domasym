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

if ! docker exec $NAME_PROJECT_CONTAINER bash -c "$@" ; then
  exit 1
else
  exit 0
fi
