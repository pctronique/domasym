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

var_version=""

while read line  
do

   if [[ "$line" =~ [0-9]+\.[0-9]+|[0-9]+\.[0-9]+\.[0-9]+ ]]; 
   then 
      var_version=${BASH_REMATCH[0]}
      break
   fi
   
done < ${0%/*}/../../$PROJECT_TMP_MAIN/recup_tmp_version.txt

rm -r -f  ${0%/*}/../../$PROJECT_TMP_MAIN/recup_valide_version.txt

echo "$var_version" >> ${0%/*}/../../$PROJECT_TMP_MAIN/recup_valide_version.txt

exit 0
