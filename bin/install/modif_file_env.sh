#!/bin/bash
if [ -z "$1" ] 
then
  echo "Entrer le nom du fichier"
	exit 1
fi

FOLDER_BASE="${0%/*}/../.."
FOLDER_ENV_TMP="$FOLDER_BASE/tmp_install"

while read LINE
do  
  echo $LINE >> $1
done <"$FOLDER_ENV_TMP/env_name"

while read LINE
do  
  echo $LINE >> $1
done <"$FOLDER_ENV_TMP/env_version"

while read LINE
do  
  echo $LINE >> $1
done <"$FOLDER_ENV_TMP/env_port"

while read LINE
do  
  echo $LINE >> $1
done <"$FOLDER_ENV_TMP/env_db"

while read LINE
do  
  echo $LINE >> $1
done <"$FOLDER_ENV_TMP/env_other"

exit 0
