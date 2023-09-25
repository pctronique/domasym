#!/bin/bash
FOLDER_BASE="${0%/*}/../.."
FOLDER_ENV_DEF="$FOLDER_BASE/.docker/file_env"
FOLDER_ENV_TMP="$FOLDER_BASE/tmp_install"
ENV_DEF="$FOLDER_ENV_DEF/.env"

if [ -z "$1" ] 
then
  echo "Entrer le nom du fichier"
	exit 1
fi

TYPE_EX="update"

if [ ! -f "$1" ]
then
  TYPE_EX="install"
fi

while read line  
do   
   export $line
done < $ENV_DEF

IFS='/' read -r -a TAB1 <<< "$0"
IFS='/' read -r -a TAB2 <<< "$(realpath $0)"

min=0
max=$(( ${#TAB1[@]} -1 ))

while [[ min -lt max ]]
do
    # Swap current first and last elements
    x="${TAB1[$min]}"
    TAB1[$min]="${TAB1[$max]}"
    TAB1[$max]="$x"

    # Move closer
    (( min++, max-- ))
done

TAB1+=(".")

min=0
max=$(( ${#TAB2[@]} -1 ))

while [[ min -lt max ]]
do
    # Swap current first and last elements
    x="${TAB2[$min]}"
    TAB2[$min]="${TAB2[$max]}"
    TAB2[$max]="$x"

    # Move closer
    (( min++, max-- ))
done

NAME_PROJECT_RECUP="$DEF_ENV_NAME_PROJECT"
for i in ${!TAB2[@]}; do
  NAME_PROJECT_RECUP=${TAB2[$i]}
  if [ ! ${TAB2[$i]} = ${TAB1[$i]} ]
  then
      break
  fi
done

DEF_NAME_PROJECT="$NAME_PROJECT_RECUP"
DEF_SGBD_DATABASE="$DEF_NAME_PROJECT"

COLOR_QUESTION=$'\e[90m'
COLOR_DEF_REP=$'\e[36m'
TEXT_BOLD=$'\e[1m'
TEXT_DEF=$'\e[0m'
TEXT_COLOR_DEF=$'\e[39m'

case "$TYPE_EX" in
  install)
    read -p $COLOR_DEF_REP$'Le nom du projet ['$COLOR_QUESTION$DEF_NAME_PROJECT$COLOR_DEF_REP$'] ? '$TEXT_COLOR_DEF name
    if [ -z "$name" ] 
    then
      name="$DEF_NAME_PROJECT"
    fi

    if [ -z "$name" ] 
    then
      exit 1
    fi

    DEF_SGBD_DATABASE="$name"
    read -p $COLOR_DEF_REP$'Le nom de base de données ['$COLOR_QUESTION$DEF_SGBD_DATABASE$COLOR_DEF_REP$'] ? '$TEXT_COLOR_DEF namedb
    if [ -z "$namedb" ] 
    then
      namedb="$DEF_SGBD_DATABASE"
    fi
    ;;

  update)
    while read line  
    do   
      export $line
    done < $1
    name=$NAME_PROJECT
    namedb=$SGBD_DATABASE
    ;;
esac

sed -i "s/NAMEPROJECT/$name/" "$FOLDER_ENV_TMP/env_name"
sed -i "s/DBNAMEBASE/$namedb/" "$FOLDER_ENV_TMP/env_db"

exit 0
