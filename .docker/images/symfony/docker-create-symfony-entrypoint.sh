#!/bin/bash

if [ -z ${PHP_FOLDER_LOG} ]
then
    PHP_FOLDER_LOG="/var/log/docker/php/"
fi

if [ -z ${CRON_FOLDER_INIT} ]
then
    CRON_FOLDER_INIT="/var/docker/cron/"
fi

if [ -z ${PHP_FOLDER_INIT} ]
then
    PHP_FOLDER_INIT="/var/docker/php/"
fi

if [ -z ${PHP_FOLDER_PROJECT} ]
then
    PHP_FOLDER_PROJECT=/home/www/
fi

${PHP_FOLDER_INIT}/createProject.sh 2>> ${PHP_FOLDER_LOG}/createproject.log

${PHP_FOLDER_INIT}/createconnsgbd.sh 2>> ${PHP_FOLDER_LOG}/createconnsgbd.log

${PHP_FOLDER_INIT}/importdata.sh 2>> ${PHP_FOLDER_LOG}/installdata.log

cp ${CRON_FOLDER_INIT}/dockercron /etc/cron.d/dockercron

crontab /etc/cron.d/dockercron

#while inotifywait -e close_write /etc/cron.d/dockercron; do crontab /etc/cron.d/dockercron; done &

crontab /etc/cron.d/dockercron

${CRON_FOLDER_INIT}/cronauto.sh 2>> ${PHP_FOLDER_LOG}/initnodejs.log &

touch ${PHP_FOLDER_LOG}/cron.log
cron && tail -f ${PHP_FOLDER_LOG}/cron.log &

echo "end create project" >> ${PHP_FOLDER_LOG}/endcreate.log

exec "$@"
