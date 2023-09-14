# creation des tmp du docker
mkdir -p projecttmp/sgbd_data
mkdir -p projecttmp/tmp
mkdir -p projecttmp/tmp/php
mkdir -p projecttmp/tmp/sgbd
mkdir -p projecttmp/log
mkdir -p projecttmp/log/php
mkdir -p projecttmp/log/xdebug
mkdir -p projecttmp/log/sgbd

# copier les configurations et fichiers
cp -R config/data/ project/www/

# modifier les droits sur les dossiers
chmod 777 -R project
chmod 777 -R projecttmp

# creation du fichier .env
if [ -e .env ]
then
    echo ""
else
    echo ""
    cp .env.example .env
fi

# creation du docker du projet
docker-compose up -d

#symfony new projectSymphony --webapp --no-git 
