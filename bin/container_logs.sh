while read line  
do   
   export $line
done < ${0%/*}/../.env

option=$1
if [[ "$option" = "" ]]
then
    option="--helps"
fi

if [[ "$option" = "--helps" ]]
then
    echo "Options:"
    echo "   --php"
    echo "   --mariadb"
    echo "   --phpmyadmin"
    echo "   --mailhog"
    echo "   --helps"
    echo "   [id ou nom du conteneur]"
else
    container=$1
    case "$container" in
        --php)
            container=$NAME_PROJECT_CONTAINER
            ;;
    
        --mariadb)
            container=$NAME_SGBD_CONTAINER
            ;;

        --phpmyadmin)
            container=$NAME_SGBD_DISPLAY_CONTAINER
            ;;

        --mailhog)
            container=$NAME_MAIL_DISPLAY_CONTAINER
            ;;
    esac

    docker logs --details $container

fi
