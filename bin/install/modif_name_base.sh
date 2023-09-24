#!/bin/bash
FOLDER_BASE="${0%/*}/../.."
FICHIER_ENV_EXA="$FOLDER_BASE/.env.example"
FILE_CONFIG="$FOLDER_BASE/config"
FILE_DATA="$FILE_CONFIG/sgbd_data"

if [ ! -e $FICHIER_ENV_EXA ]
then
    echo "Problème lors de l'installation, il manque un fichier de base pour la création des variables d'environnement."
    exit 1
fi

while read line  
do   
   export $line
done < $FICHIER_ENV_EXA

sed -i "s/dbname/$SGBD_DATABASE/" "$FILE_DATA/0000_default.sql"
sed -i "s/dbname/$SGBD_DATABASE/" "$FILE_DATA/0001_people.sql"
sed -i "s/dbname/$SGBD_DATABASE/" "$FILE_CONFIG/.env.local"

exit 0
