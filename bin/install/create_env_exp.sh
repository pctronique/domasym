#!/bin/bash
FOLDER_BASE="${0%/*}/../.."
FOLDER_DOCKER="$FOLDER_BASE/.docker"
FOLDER_DOCKER_CONF="$FOLDER_DOCKER/config"
FOLDER_ENV_DEF="$FOLDER_DOCKER/file_env"
FOLDER_ENV_TMP="$FOLDER_BASE/tmp_install"
ENV_DEF="$FOLDER_ENV_DEF/.env"
FILE_EXP="$FOLDER_BASE/.env.example"
FILE_ENV="$FOLDER_BASE/.env"

TYPE_EX="update"
FILE_EXC="$FILE_ENV"

if [ ! -f "$FILE_EXP" ]
then
  TYPE_EX="install"
fi

while read line  
do   
   export $line
done < $ENV_DEF

rm -f "$FILE_ENV"
mkdir -p "$FOLDER_ENV_TMP"
cp "$FOLDER_ENV_DEF/env_name" "$FOLDER_ENV_TMP/env_name"
cp "$FOLDER_ENV_DEF/env_version" "$FOLDER_ENV_TMP/env_version"
cp "$FOLDER_ENV_DEF/env_port" "$FOLDER_ENV_TMP/env_port"
cp "$FOLDER_ENV_DEF/env_db" "$FOLDER_ENV_TMP/env_db"
cp "$FOLDER_ENV_DEF/env_other" "$FOLDER_ENV_TMP/env_other"

if [ ! -f "$FOLDER_ENV_TMP/type_install" ]
then
  echo "TYPE_INSTALL_PROJECT=$TYPE_EX" >> "$FOLDER_ENV_TMP/type_install"
fi

if [ ! -f "$FOLDER_DOCKER/$DOCKER_FOLDER_PROJECT/Dockerfile" ]
then
  cp "$FOLDER_DOCKER/$DOCKER_FOLDER_PROJECT/Dockerfile.example" "$FOLDER_DOCKER/$DOCKER_FOLDER_PROJECT/Dockerfile"
fi

if [ ! -f "$FOLDER_BASE/docker-compose.yml" ]
then
  cp "$FOLDER_DOCKER_CONF/docker-compose.yml.example" "$FOLDER_BASE/docker-compose.yml"
fi

COLOR_QUESTION=$'\e[90m'
COLOR_DEF_REP=$'\e[36m'
TEXT_BOLD=$'\e[1m'
TEXT_DEF=$'\e[0m'
TEXT_COLOR_DEF=$'\e[39m'

RENUMB='^[0-9]+$'

echo -e $TEXT_BOLD$COLOR_DEF_REP$'Pour la création des conteneurs du projet, il faut répondre à quelque question.'


if ! ${0%/*}/create_env_name.sh "$FILE_EXP" ; then
  exit 1
fi

if [ $TYPE_EX = "install" ]
then
  sed -i "s/PROJECTPORT/$DEF_ENV_PROJECT_PORT/" "$FOLDER_ENV_TMP/env_port"
  sed -i "s/SGBDDISPLAYPORT/$DEF_ENV_SGBD_DISPLAY_PORT/" "$FOLDER_ENV_TMP/env_port"
  sed -i "s/MAILDISPLAYPORT/$DEF_ENV_MAIL_DISPLAY_PORT/" "$FOLDER_ENV_TMP/env_port"

  if ! ${0%/*}/modif_file_env.sh $FILE_EXP ; then
    exit 1
  fi

  if ! ${0%/*}/move_file_config.sh ; then
    exit 1
  fi

  if ! ${0%/*}/modif_name_project.sh ; then
    exit 1
  fi

  if ! ${0%/*}/modif_name_base.sh ; then
    exit 1
  fi
fi

cp "$FOLDER_ENV_DEF/env_port" "$FOLDER_ENV_TMP/env_port"

if ! ${0%/*}/create_env_port.sh ; then
  exit 1
fi

echo -e $TEXT_DEF

if ! ${0%/*}/modif_file_env.sh $FILE_ENV ; then
  exit 1
fi

exit 0
