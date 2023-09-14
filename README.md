# dmasy (Docker ANGUlar)

La base docker pour un projet en nodejs. Contient une base d'un serveur nodejs.

<details>
  <summary>Table des matières</summary>
  <ol>
    <li><a href="#installé-à-la-base-du-projet-docker">Installé à la base du projet docker</a></li>
    <li>
        <a href="#création-du-conteneur-docker">Création du conteneur (Docker)</a>
        <ul>
            <li><a href="#le-fichier-env">Le fichier .env</a></li>
            <li><a href="#modifier-l-adresse-de-port">Modifier l'adresse de port</a></li>
            <li><a href="#installer-le-conteneur">Installer le conteneur</a></li>
            <li><a href="#modifier-le-fichier-d-intallation">Modifier le fichier d'intallation</a></li>
            <li><a href="#modifier-les-versions">Modifier les versions</a></li>
        </ul>
    </li>
    <li><a href="#rechercher-un-package-docker">Rechercher un package (Docker)</a></li>
    <li>
        <a href="#install-un-package-docker">Install un package (Docker)</a>
        <ul>
            <li><a href="#le-fichier-env">Le fichier .env</a></li>
            <li><a href="#dans-dockerfile">Dans Dockerfile</a></li>
        </ul>
    </li>
    <li><a href="#le-dossier-du-projet">Le dossier du projet</a></li>
    <li><a href="#mini-projet-nodejs">Mini projet nodejs</a></li>
    <li><a href="#les-commandes-angular-dans-le-mini-projet">Les commandes angular dans le mini-projet</a></li>
    <li><a href="#visualiser-les-messages-de-la-console-ou-les-logs">Visualiser les messages de la console ou les logs</a></li>
  </ol>
</details>
    
## Installé à la base du projet docker
* [docker phpmyadmin](https://hub.docker.com/_/phpmyadmin/)
* [docker mariadb](https://hub.docker.com/_/mariadb)
* [docker mailhog](https://hub.docker.com/r/mailhog/mailhog/)
* [docker php](https://hub.docker.com/_/php)
* pm2 (docker nodeJS)
* angular (docker nodeJS)

## Création du conteneur (Docker)
Vous devez avoir installé Docker. 
Pour la création du conteneur docker pour le projet.
### Le fichier .env
Modifier le contenu du fichier .env.example :
```
NAME_PROJECT=dangu
NAME_NODEJS_CONTAINER=dangu_httpd
NAME_SGBD_CONTAINER=dangu_mongo
```
Par le nom de votre projet, par exemple 'nameProject' :
```
NAME_PROJECT=nameProject
NAME_NODEJS_CONTAINER=nameProject_httpd
NAME_SGBD_CONTAINER=nameProject_mongo
```
Créé un fichier "**.env**" à partir du fichier "**.env.example**" (copier/coller). <br />
> [!WARNING]
> Attention de conserver le fichier "**.env.example**".

### Modifier l'adresse de port
Si vous avez besoin de modifier le port, merci de le faire dans le fichier "**.env**".<br />
> [!WARNING]
> Ne surtout pas le faire dans le fichier "**.env.example**".<br />

Un port de votre pc peut être utilisé par un autre projet, il faudra donc modifier celui-ci. Ce qui est vrai sur un pc, ne le sera pas sur les autres, donc on ne modifit pas les valeurs dans le fichier "**.env.example**".<br />
Il est préférable d'incrémenter à l'identique les ports du projet.<br />
Je dois incrémenter de 9 un des ports, je le fais aussi pour les autres. Ceci évite de se perdre dans les ports disponibles.<br />
Exemple :<br />
```
VALUE_NODEJS_PORT=4209
VALUE_SGBD_PORT=27029
```

### Installer le conteneur
Vous pouvez créer votre conteneur.
```
$ ./install.sh
```

### Modifier le fichier d'intallation
Après l'installation, il faudra modifier le contenu du fichier "**install.sh**" :
```
./createProject.sh
#./npmInstall.sh
./start.sh
```
Par :
```
#./createProject.sh
./npmInstall.sh
./start.sh
```
Si ce n'est pas déjà fait.

### Modifier les versions
> [!WARNING]
> Il est indispensable de le faire pour pouvoir utiliser un conteneur identique des années plus tard.

Sur le projet actuel, on utilise les nouvelles versions ce qui peut poser des problèmes sur le projet par la suite. Il est préférable d'utiliser la version utilisée lors de la création du projet.
<br />[docker nodejs](https://hub.docker.com/_/node/)
<br /><img src="./images/Screenshot_20230914_092538.png" alt="exemple angular server" width="300" height="175"><br />
```
$ ./bin/terminal.sh
# nodejs -v
v20.6.1
# ng version
Angular CLI: 16.2.2
```
Dand le fichier "**.docker/angular/Dockerfile**", remplacé '**latest**' par la bonne version disponible pour docker :
```
FROM node:latest
```
```
FROM node:20.6.1
```
Dans le même fichier, modifier l'installation angular par la bonne version :
```
RUN npm install -y --no-install-recommends @angular/cli -g
```
```
RUN npm install -y --no-install-recommends @angular/cli@16.2.2 -g
```
<br />

> [!NOTE]
> Il n'est pas possible de choisir une version pour mongoDB, mais ceci ne pose pas de problème.

## Rechercher un package (Docker)
Si vous avez besoin d'un package pour votre projet dans le conteneur. Vous pouvez rechercher les packages disponibles pour le conteneur.
```
$ ./bin/terminal.sh
# apt-cache search name_package
```

## Install un package (Docker)
Si vous avez besoin d'installer un package dans votre conteneur.
```
$ ./bin/terminal.sh
# apt install name_package
```

### Dans Dockerfile
Quand vous installez un package, vous devez aussi le rajouter dans le fichier "**.docker/linux_agcc/Dockerfile**", pour le conserver. Vous devez ajouter la ligne suivante à la fin du fichier avec le bon nom de package.
```
RUN apt install name_package
```

## Le dossier du projet
Votre code devra être placé dans le dossier "**project**".

## Mini-projet nodejs
Il y a un mini-projet angular pour vous montrer un exemple, mais vous pouvez le retirer en vidant le dossier "**project**".<br />
> [!WARNING]
> Ne surtout pas supprimer le fichier "**.gitignore**" du dossier "**project**".<br />

Lors de l'installation, il démarre le serveur angular du mini-projet sur '**localhost:4200**' si vous n'avez pas modifié le port (sinon il faut modifier le numéro de port du lien) :
<br /><img src="./images/Screenshot_20230914_092616.png" alt="exemple angular server" width="300" height="175"><br />
Vous pouvez modifier le démarrage de votre projet dans le fichier "**createProject.sh**" :
```
docker exec $NAME_NODEJS_CONTAINER bash -c "ng new projectAngular --routing --defaults --skip-git && cp .gitignore projectAngular/"
```
Dans le fichier "**npmInstall.sh**" :
```
docker exec $NAME_NODEJS_CONTAINER bash -c "cd projectAngular && npm install"
```
Dans le fichier "**start.sh**" :
```
docker exec $NAME_NODEJS_CONTAINER bash -c "cd projectAngular && ng serve --host 0.0.0.0 >> ../../projecttmp/logs/angular/ng_out.log 2>> ../../projecttmp/logs/angular/ng_error.log" &
```
Quand vous allez redémarrer le pc, il faudra relancer le serveur Nodejs avec la commande :
```
$ ./start.sh
```

## Les commandes angular dans le mini-projet
Vous allez avoir besoin de faire des commandes angular sur votre code, pour ce faire :
```
$ ./bin/terminal.sh
# cd projectAngular/
# ng generate component hero-detail
# ng generate component xyz
```

## Visualiser les messages de la console ou les logs
Les messages de la console sont transmis dans un fichier et ne sont pas visibles sur le terminal.<br />
* Message sur la console dans le fichier : "**projecttmp/logs/angular/ng_out.log**".
* Message d'erreur sur la console dans le fichier : "**projecttmp/logs/angular/ng_error.log**".



```
$ ./bin/terminal_mariadb.sh
# mariadb -V
mariadb  Ver 15.1 Distrib 10.7.3-MariaDB, for debian-linux-gnu (x86_64) using readline 5.2
```

