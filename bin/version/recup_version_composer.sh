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

${0%/*}/version_in_project.sh "composer -V"
${0%/*}/recup_version.sh

value_vers=""

while read lineVers 
do
   value_vers="$lineVers"
done < ${0%/*}/../../$PROJECT_TMP_MAIN/recup_valide_version.txt

echo "COMPOSER_VERSION=$value_vers" >> "${0%/*}/../../$PROJECT_TMP_MAIN/env_version.txt"
