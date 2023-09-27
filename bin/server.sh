#!/bin/bash
if ! ${0%/*}/install/message_create_container.sh ; then
   exit 1
fi

while read line  
do   
    if [ ! -z "$line" ]
    then
        export $line
    fi
done < ${0%/*}/../.env

d_start () {
   rm -f -r "/tmp/mess_project_docker.log"
   docker container start $NAME_PROJECT_CONTAINER >> /tmp/mess_project_docker.log
   rm -f -r "/tmp/mess_project_docker.log"
}

d_stop () {
   rm -f -r "/tmp/mess_project_docker.log"
   docker container stop $NAME_PROJECT_CONTAINER >> /tmp/mess_project_docker.log
   rm -f -r "/tmp/mess_project_docker.log"
}
 
d_restart () {
   d_stop
   d_start
}

d_log () {
   docker exec $NAME_PROJECT_CONTAINER bash -c "service startserver log"
}

option=$1
if [[ "$option" = "" ]]
then
    option="--helps"
fi

case "$1" in
   start|stop|log)
      d_${1}
      ;;
   
   restart|reload)
      d_restart
      ;;
   
   *)
      echo "$ .server.sh [option]"
      echo "Options:"
      echo "   start      : Pour démarrer le serveur."
      echo "   stop       : Pour arrêter le serveur."
      echo "   restart    : Pour redémarrer le serveur."
      echo "   reload     : Pour redémarrer le serveur."
      echo "   log        : Afficher les logs."
      echo "   --helps    : Pour afficher l'aide."
      ;;

esac

exit 0
