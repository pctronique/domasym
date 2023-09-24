#!/bin/bash
if [ ! -e ${0%/*}/../../.env ]
then
   echo "Merci de créer les conteneurs du projet avant d'utiliser cette commande."
   exit 1
fi

exit 0
