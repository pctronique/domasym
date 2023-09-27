#!/bin/bash
if ! ${0%/*}/message_create_container.sh ; then
   exit 1
fi

FOLDER_BASE="${0%/*}/../.."

while read line  
do   
    if [ ! -z "$line" ]
    then
        export $line
    fi
done < "$FOLDER_BASE/.env"

NUM_PORT_PROJECT=""
NUM_PORT_SGBD_DISPLAY=""
NUM_PORT_MAIL_DISPLAY=""

if [ ! "$VALUE_PROJECT_PORT" = "80" ]
then
   NUM_PORT_PROJECT=":$VALUE_PROJECT_PORT"
fi

if [ ! "$VALUE_SGBD_DISPLAY_PORT" = "80" ]
then
   NUM_PORT_SGBD_DISPLAY=":$VALUE_SGBD_DISPLAY_PORT"
fi

if [ ! "$VALUE_MAIL_DISPLAY_PORT" = "80" ]
then
   NUM_PORT_MAIL_DISPLAY=":$VALUE_MAIL_DISPLAY_PORT"
fi

COLOR_QUESTION=$'\e[90m'
COLOR_DEF_REP=$'\e[36m'
TEXT_BOLD=$'\e[1m'
TEXT_DEF=$'\e[0m'
TEXT_COLOR_DEF=$'\e[39m'

echo -e "$TEXT_BOLD$COLOR_DEF_REP Pour visualiser le projet         :$TEXT_COLOR_DEF http://localhost$NUM_PORT_PROJECT $TEXT_DEF"
echo -e "$TEXT_BOLD$COLOR_DEF_REP Pour visualiser la base de donnée :$TEXT_COLOR_DEF http://localhost$NUM_PORT_SGBD_DISPLAY $TEXT_DEF"
echo -e "$TEXT_BOLD$COLOR_DEF_REP Pour visualiser les emails        :$TEXT_COLOR_DEF http://localhost$NUM_PORT_MAIL_DISPLAY $TEXT_DEF"

exit 0
