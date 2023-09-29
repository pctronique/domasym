#!/bin/bash
if ! ${0%/*}/message_create_container.sh ; then
   exit 1
fi

TYPE_SYS="all"
for arg in "$@"
do
  case "$arg" in
    --win)
      TYPE_SYS="win"
      ;;

    --mac)
      TYPE_SYS="mac"
      ;;

  esac
done

FOLDER_BASE="${0%/*}/../.."
FOLDER_DOCKER="$FOLDER_BASE/.docker"
FOLDER_DOCKER_CONF="$FOLDER_DOCKER/config"
FOLDER_ENV_DEF="$FOLDER_DOCKER/file_env"
FOLDER_ENV_TMP="$FOLDER_BASE/tmp_install"
ENV_DEF="$FOLDER_ENV_DEF/.env"
FILE_EXP="$FOLDER_BASE/.env.example"
FILE_ENV="$FOLDER_BASE/.env"

if [ -f $FOLDER_BASE/tmp_install/web_display ]
then
  while read line  
  do
    if [ ! -z "$line" ]
    then
      export $line
    fi
  done < $FOLDER_BASE/tmp_install/web_display
else
  IS_DISPLAY_WEB="FALSE"
fi

while read line  
do   
    if [ ! -z "$line" ]
    then
        export $line
    fi
done < "$FOLDER_BASE/.env"

while read line  
do
    if [ ! -z "$line" ]
    then
        export $line
    fi
done < $ENV_DEF

if [ ! -f $FOLDER_ENV_TMP/web_display ]
then
   while read line  
   do
      if [ ! -z "$line" ]
      then
         export $line
      fi
   done < "$FOLDER_ENV_TMP/web_display"
fi

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

COLOR_QUESTION=$'\e'$INST_COLOR_QUESTION
COLOR_DEF_REP=$'\e'$INST_COLOR_DEF_REP
COLOR_ERROR_REP=$'\e'$INST_COLOR_ERROR_REP
TEXT_BOLD=$'\e'$INST_TEXT_BOLD
TEXT_DEF=$'\e'$INST_TEXT_DEF
TEXT_COLOR_DEF=$'\e'$INST_TEXT_COLOR_DEF

echo "" >> "$FOLDER_ENV_TMP/web_lien"

rm -r -f "$FOLDER_ENV_TMP/web_lien"

if [ "$IS_DISPLAY_WEB" = "TRUE" ]
then
   echo "http://localhost$NUM_PORT_SGBD_DISPLAY" >> "$FOLDER_ENV_TMP/web_lien"
   echo "http://localhost$NUM_PORT_PROJECT" >> "$FOLDER_ENV_TMP/web_lien"
   echo "http://localhost$NUM_PORT_MAIL_DISPLAY" >> "$FOLDER_ENV_TMP/web_lien"
   #sensible-browser "http://localhost$NUM_PORT_SGBD_DISPLAY" 2> /dev/null &
   #sensible-browser "http://localhost$NUM_PORT_PROJECT" 2> /dev/null &
   #sensible-browser "http://localhost$NUM_PORT_MAIL_DISPLAY" 2> /dev/null  &
fi

if [ ! "$TYPE_SYS" = "win" ]
then
   if [ -f "$FOLDER_ENV_TMP/web_lien" ]
   then
   while read line  
   do
      if [ ! -z "$line" ]
      then
         #sensible-browser "$line" 2> /dev/null &
         if [ ! "$TYPE_SYS" = "mac" ]
         then
            xdg-open "$line"
         else
            open "$line"
         fi
      fi
   done < "$FOLDER_ENV_TMP/web_lien"
   fi
fi

echo -e "$TEXT_BOLD$COLOR_DEF_REP Pour visualiser le projet         :$TEXT_COLOR_DEF http://localhost$NUM_PORT_PROJECT $TEXT_DEF"
echo -e "$TEXT_BOLD$COLOR_DEF_REP Pour visualiser la base de donnée :$TEXT_COLOR_DEF http://localhost$NUM_PORT_SGBD_DISPLAY $TEXT_DEF"
echo -e "$TEXT_BOLD$COLOR_DEF_REP Pour visualiser les emails        :$TEXT_COLOR_DEF http://localhost$NUM_PORT_MAIL_DISPLAY $TEXT_DEF"

exit 0
