#!/bin/bash
FOLDER_BASE="${0%/*}/../.."
FOLDER_ENV_DEF="$FOLDER_BASE/.docker/file_env"
ENV_DEF="$FOLDER_ENV_DEF/.env"

while read line  
do   
    if [ ! -z "$line" ]
    then
        export $line
    fi
done < $ENV_DEF

COLOR_QUESTION=$'\e'$INST_COLOR_QUESTION
COLOR_DEF_REP=$'\e'$INST_COLOR_DEF_REP
COLOR_ERROR_REP=$'\e'$INST_COLOR_ERROR_REP
TEXT_BOLD=$'\e'$INST_TEXT_BOLD
TEXT_DEF=$'\e'$INST_TEXT_DEF
TEXT_COLOR_DEF=$'\e'$INST_TEXT_COLOR_DEF

echo -e $TEXT_BOLD$COLOR_DEF_REP$'Pour la création des conteneurs du projet, il faut répondre à quelque question.'
