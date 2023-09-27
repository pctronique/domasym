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

if ! ${0%/*}/../install/project_bash.sh "rm -r -f $PROJECT_TMP/recup_tmp_version.txt" ; then
   exit 1
fi

if ! ${0%/*}/../install/project_bash.sh "$@ >> $PROJECT_TMP/recup_tmp_version.txt" ; then
   exit 1
fi
