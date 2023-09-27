#!/bin/bash
if ! ${0%/*}/message_create_container.sh ; then
   exit 1
fi

while read line  
do   
    if [ ! -z "$line" ]
    then
        export $line
    fi
done < ${0%/*}/../../.env

if ! ${0%/*}/php_create_config.sh ; then
  exit 1
fi

if ! ${0%/*}/project_bash.sh "symfony new $FOLDER_PROJECT --no-git $@" ; then
  exit 1
fi
if ! ${0%/*}/project_bash.sh "chmod 777 -R $FOLDER_PROJECT" ; then
  exit 1
fi

if ! ${0%/*}/in_install.sh ; then
  exit 1
fi

if ! ${0%/*}/project_bash.sh "chmod 777 -R $FOLDER_PROJECT" ; then
  exit 1
fi

cd ${0%/*}/../../
if ! docker compose up -d ; then
  exit 1
fi

if [ -e ${0%/*}/packages_install.list ]
then
  while read line  
  do   
    if [ ! -z "$line" ]
    then
      if ! ${0%/*}/project_bash.sh "cd $FOLDER_PROJECT/ && composer require $line" ; then
        exit 1
      fi
    fi
  done < ${0%/*}/packages_install.list
fi

if ! ${0%/*}/project_bash.sh "cd $FOLDER_PROJECT/ && php bin/console doctrine:database:create" ; then
   exit 0
fi
