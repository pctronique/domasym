# creation des tmp du docker
mkdir -p projecttmp/sgbd_data
mkdir -p projecttmp/tmp
mkdir -p projecttmp/tmp/php
mkdir -p projecttmp/tmp/sgbd
mkdir -p projecttmp/logs
mkdir -p projecttmp/logs/symfony
mkdir -p projecttmp/logs/php
mkdir -p projecttmp/logs/sgbd

touch projecttmp/logs/symfony/symfony_out.log
touch projecttmp/logs/symfony/symfony_error.log

# modifier les droits sur les dossiers
chmod 777 -R project
chmod 777 -R projecttmp

 # creation du fichier .gitignore
if [ ! -e project/.gitignore ]
then
    cp .docker/config/gitignore_symphony project/.gitignore
fi

 # creation du fichier env.local.example
if [ ! -e project/.env.local.example ]
then
    cp .docker/config/env.local.example project/.env.local.example
fi

# creation du fichier .env
if [ ! -e .env ]
then
    cp .env.example .env
fi

# creation du docker du projet
docker-compose up -d

./bin/createProject.sh
#./bin/updateProject.sh
./start.sh
