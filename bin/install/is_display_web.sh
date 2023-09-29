#!/bin/bash
FOLDER_BASE="${0%/*}/../.."
FOLDER_ENV_DEF="$FOLDER_BASE/.docker/file_env"
FOLDER_ENV_TMP="$FOLDER_BASE/tmp_install"
ENV_DEF="$FOLDER_ENV_DEF/.env"

while read line  
do   
    if [ ! -z "$line" ]
    then
        export $line
    fi
done < $ENV_DEF

mkdir -p "$FOLDER_ENV_TMP"

rm -r -f "$FOLDER_ENV_TMP/web_display"

COLOR_QUESTION=$'\e'$INST_COLOR_QUESTION
COLOR_DEF_REP=$'\e'$INST_COLOR_DEF_REP
COLOR_ERROR_REP=$'\e'$INST_COLOR_ERROR_REP
TEXT_BOLD=$'\e'$INST_TEXT_BOLD
TEXT_DEF=$'\e'$INST_TEXT_DEF
TEXT_COLOR_DEF=$'\e'$INST_TEXT_COLOR_DEF

if ! ${0%/*}/message_before_question.sh ; then
   exit 1
fi

read -p $COLOR_DEF_REP$'Voulez-vous afficher les pages web à la fin de l\'installation ? ['$COLOR_QUESTION$'Y/n'$COLOR_DEF_REP$'] ? '$TEXT_COLOR_DEF is_web
if [ -z "$is_web" ] 
then
  is_web="Y"
fi

is_web="$(tr [A-Z] [a-z] <<< "$is_web")"
is_web=${is_web:0:1}

if [ -z "$is_web" ] 
then
  echo -e $COLOR_ERROR_REP$'Merci d\'entrer une valeur valide.'$TEXT_COLOR_DEF
  exit 1
fi

if [ "$is_web" = "y" ] 
then
  echo "IS_DISPLAY_WEB=TRUE" >> "$FOLDER_ENV_TMP/web_display"
else
  echo "IS_DISPLAY_WEB=FALSE" >> "$FOLDER_ENV_TMP/web_display"
fi

exit 0
