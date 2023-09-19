while read line  
do   
   export $line
done < ${0%/*}/../.env

d_start () {
   docker container start $NAME_SYMFONY_CONTAINER
   docker exec $NAME_SYMFONY_CONTAINER /etc/init.d/startserver start
}

d_stop () {
   docker container stop $NAME_SYMFONY_CONTAINER
}
 
d_restart () {
   d_stop
   d_start
}

option=$1
if [[ "$option" = "" ]]
then
    option="--helps"
fi

if [[ "$option" = "--helps" ]]
then
    echo "Options:"
    echo "   start"
    echo "   stop"
    echo "   restart"
    echo "   reload"
    echo "   --helps"
else
   case "$1" in
      start|stop)
         d_${1}
         ;;
   
      restart|reload)
         d_restart
         ;;

      helps)
         echo "Usage: ./bin/server.sh {start|stop|restart|reload|helps}"
         exit 1
         ;;

   esac
fi
