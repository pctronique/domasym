#!/bin/bash
FOLDER_BASE="${0%/*}/../.."
FOLDER_ENV_DEF="$FOLDER_BASE/.docker/file_env"
FOLDER_ENV_TMP="$FOLDER_BASE/install_tmp"
ENV_DEF="$FOLDER_ENV_DEF/.env"

while read line  
do   
  export $line
done < $ENV_DEF

DEF_PROJECT_PORT="$DEF_ENV_PROJECT_PORT"
DEF_SGBD_DISPLAY_PORT="$DEF_ENV_SGBD_DISPLAY_PORT"
DEF_MAIL_DISPLAY_PORT="$DEF_ENV_MAIL_DISPLAY_PORT"

COLOR_QUESTION=$'\e[90m'
COLOR_DEF_REP=$'\e[36m'
TEXT_BOLD=$'\e[1m'
TEXT_DEF=$'\e[0m'
TEXT_COLOR_DEF=$'\e[39m'

RENUMB='^[0-9]+$'

read -p $COLOR_DEF_REP$'Le numéro de port pour le projet ['$COLOR_QUESTION$DEF_PROJECT_PORT$COLOR_DEF_REP$'] ? '$TEXT_COLOR_DEF portProject
if [ -z "$portProject" ] 
then
  portProject="$DEF_PROJECT_PORT"
else
  if ! [[ $portProject =~ $RENUMB ]] ; then
    echo "Merci d'entrer un nombre." >&2; exit 1
  fi
fi

read -p $COLOR_DEF_REP$'Le numéro de port pour visualiser la base de donnée ['$COLOR_QUESTION$DEF_SGBD_DISPLAY_PORT$COLOR_DEF_REP$'] ? '$TEXT_COLOR_DEF portSgbdDisp
if [ -z "$portSgbdDisp" ] 
then
  portSgbdDisp="$DEF_SGBD_DISPLAY_PORT"
else
  if ! [[ $portSgbdDisp =~ $RENUMB ]] ; then
    echo "Merci d'entrer un nombre." >&2; exit 1
  fi
fi

read -p $COLOR_DEF_REP$'Le numéro de port pour visualiser les emails ['$COLOR_QUESTION$DEF_MAIL_DISPLAY_PORT$COLOR_DEF_REP$'] ? '$TEXT_COLOR_DEF portEmail
if [ -z "$portEmail" ] 
then
  portEmail="$DEF_MAIL_DISPLAY_PORT"
else
  if ! [[ $portEmail =~ $RENUMB ]] ; then
    echo "Merci d'entrer un nombre." >&2; exit 1
  fi
fi

sed -i "s/PROJECTPORT/$portProject/" "$FOLDER_ENV_TMP/env_port"
sed -i "s/SGBDDISPLAYPORT/$portSgbdDisp/" "$FOLDER_ENV_TMP/env_port"
sed -i "s/MAILDISPLAYPORT/$portEmail/" "$FOLDER_ENV_TMP/env_port"

exit 0
