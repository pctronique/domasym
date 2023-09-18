while read line  
do   
   export $line
done < ${0%/*}/../.env

option=$@
if [[ "$option" = "" ]]
then
    option="--help"
fi

if [[ "$option" = "--help" ]]
then
    echo "Options:"
    echo " --php"
    echo " --mariadb"
    echo " --phpmyadmin"
    echo " --mailhog"
    echo " [id ou nom du conteneur]"
else
    container=$@
    case "$container" in
        --php)
            container=$NAME_SYMFONY_CONTAINER
            ;;
    
        --mariadb)
            container=$NAME_MARIABD_CONTAINER
            ;;

        --phpmyadmin)
            container=$NAME_PHPMYADMIN_CONTAINER
            ;;

        --mailhog)
            container=$NAME_MAILHOG_CONTAINER
            ;;
    esac

    docker logs --details $container

fi
