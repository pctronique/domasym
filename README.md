# domasym (DOcker MAriadb SYMfony)

La base docker pour un projet en nodejs. Contient une base d'un serveur nodejs.

<details>
  <summary>Table des matières</summary>
  <ol>
    <li>
        <a href="#présentation">Présentation</a>
        <ul>
            <li><a href="#l-avantage-d-utiliser-docker">L'avantage d'utiliser docker</a></li>
            <li><a href="#conteneur-angular">Conteneur angular</a></li>
            <li><a href="#conteneur-mailhog">Conteneur mailhog</a></li>
            <li><a href="#conteneur-mongo-express">Conteneur mongo-express</a></li>
            <li><a href="#conteneur-mongo">Conteneur mongo</a></li>
            <li><a href="#conteneurs-sgbd">Conteneurs SGBD</a></li>
        </ul>
    </li>
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
    <li>
        <a href="#mini-projet-nodejs">Mini projet angular</a>
        <ul>
            <li><a href="#le-fichier-env">Le fichier .env</a></li>
            <li><a href="#options-pour-la-création-du-projet-angular">Options pour la création du projet angular</a></li>
        </ul>
    </li>
    <li><a href="#les-commandes-angular-dans-le-mini-projet">Les commandes angular dans le mini-projet</a></li>
    <li><a href="#visualiser-les-messages-de-la-console-ou-les-logs">Visualiser les messages de la console ou les logs</a></li>
  </ol>
</details>

## Présentation
La base docker pour un projet angular. Ceci est une base, vous pouvez le modifier selon vos besoins.<br />
> [!WARNING]
> Vous devez installer docker pour pouvoir l'utiliser.

### L'avantage d'utiliser docker
Lorsque vos faites un projet avec docker vous devez transmettre la totalité du projet, les fichiers de création des conteneurs et le code. Pour ce projet, vous devez transmettre le contenu en totalité du dossier "**domasym**" (**que vous pouvez et surtout devez le renommer au nom de votre projet**) dans un git.<br />
Les avantages :<br />
* Pas de programme à installer sur votre pc (à part docker et un éditeur ou IDE)
* Travailler à plusieurs avec les mêmes conteneurs à l'identique
* Prêt à travailler directement sur le code après la création des conteneurs
* Avoir une base prés remplie lors de la création des conteneurs.<sup>(1)</sup>
<br /> Après installation des conteneurs, on peut directement continuer le code.
<sup>(1) [Conteneur mongo](#conteneur-mongo)</sup>

### Conteneur angular
Il est conçu à partir de l'image du [docker nodeJS](https://hub.docker.com/_/node/).<br />
Il contiendra vos codes.<br />
Il installe aussi dans le conteneur :<br />
* [angular](https://angular.io/cli/serve)

<br /> 
C'est dans ce conteneur que vous allez placer vos codes angular, dans le dossier "**project**" (qui est lié au conteneur).
<br /><img src="./images/Screenshot_20230914_092616.png" alt="exemple nodejs server" width="300" height="175"><br />

### Conteneur mailhog
Il est conçu à partir de l'image du [docker mailhog](https://hub.docker.com/r/mailhog/mailhog/).<br />
Ce conteneur va vous permettre de visualiser les emails transmis par votre projet nodeJS.
<br /><img src="./images/screen65.jpg" alt="exemple nodejs server" width="300" height="175"><br />

### Conteneur mongo-express
Il est conçu à partir de l'image du [docker mongo-express](https://hub.docker.com/r/mailhog/mailhog/).<br />
Ce conteneur va vous permettre de visualiser votre base de données mongodb (NOSQL).
<br /><img src="./images/screen68.jpg" alt="exemple nodejs server" width="300" height="175"><br />

### Conteneur mongo
Il est conçu à partir de l'image du [docker mongo](https://hub.docker.com/_/mongo).<br />
Ce conteneur contiendra votre base de donnée. Il est possible de visualiser son contenu à partir du [conteneur mongo-express](#conteneur-mongo-express)<br />
Il est possible d'entrer des tables lors de sa création, pour se faire il faudra récupérer les tables sous format json et les placer dans un dossier et modifier le fichier "**docker-compose.yml**".<br />
J'ai mis en place un exemple avec la table people "**people.json**" :
```
# start data
- ./.docker/sgbd_data/people.json:/mongo-seed/people.json
# end data
```
<br /><img src="./images/screen69.jpg" alt="exemple nodejs server" width="300" height="175"><br />

> [!NOTE]
> Vous pouvez changer de SGBD pour un SQL. Pour les projet en nodeJS on utilise principalement un SGBD NOSQL.

### Conteneurs SGBD
Ici je vais présenter quelques conteneurs SGBD et leurs visionneurs sous le format d'un tableau :

| SGBD | visionneur |
| ------------- | ------------- |
| [mariadb](https://hub.docker.com/_/mariadb) | [phpmyadmin](https://hub.docker.com/r/phpmyadmin/phpmyadmin/) |
| [mysql](https://hub.docker.com/_/mysql) | [phpmyadmin](https://hub.docker.com/r/phpmyadmin/phpmyadmin/) |
| [postgres](https://hub.docker.com/_/postgres) | [phppgadmin](https://hub.docker.com/r/dockage/phppgadmin) |
| [mongo](https://hub.docker.com/_/mongo) | [mongo-express](https://hub.docker.com/r/mailhog/mailhog/) |

Ceci est une petite partie des [SGBD](https://fr.wikipedia.org/wiki/Syst%C3%A8me_de_gestion_de_base_de_donn%C3%A9es), vous pouvez vérifier la disponibilité de votre SGBD dans [docker hub](https://hub.docker.com/).

## Création du conteneur (Docker)
Vous devez avoir installé Docker. 
Pour la création du conteneur docker pour le projet.
### Le fichier .env
Modifier le contenu du fichier "**.env.example**" :
```
NAME_PROJECT=domasym
NAME_ANGULAR_CONTAINER=domasym_angular
NAME_SGBD_CONTAINER=domasym_mongo
NAME_MOEXPRESS_CONTAINER=domasym_moexpress
NAME_MAILHOG_CONTAINER=domasym_mailhog
```
Par le nom de votre projet, par exemple 'nameProject' :
```
NAME_PROJECT=nameProject
NAME_ANGULAR_CONTAINER=nameProject_angular
NAME_SGBD_CONTAINER=nameProject_mongo
NAME_MOEXPRESS_CONTAINER=nameProject_moexpress
NAME_MAILHOG_CONTAINER=nameProject_mailhog
```
Créé un fichier "**.env**" à partir du fichier "**.env.example**" (copier/coller). <br />
> [!WARNING]
> Attention de conserver le fichier "**.env.example**".

### Modifier l'adresse de port
Si vous avez besoin de modifier le port, merci de le faire dans le fichier "**.env**".<br />
> [!WARNING]
> Ne surtout pas le faire dans le fichier "**.env.example**".

<br />Un port de votre pc peut être utilisé par un autre projet, il faudra donc modifier celui-ci. Ce qui est vrai sur un pc, ne le sera pas sur les autres, donc on ne modifit pas les valeurs dans le fichier "**.env.example**".<br />
Il est préférable d'incrémenter à l'identique les ports du projet.<br />
Je dois incrémenter de 9 un des ports, je le fais aussi pour les autres. Ceci évite de se perdre dans les ports disponibles.<br />
Exemple :<br />
```
VALUE_ANGULAR_PORT=4209
VALUE_SGBD_PORT=27029
VALUE_MOEXPRESS_PORT=8089
VALUE_MAILHOG_DISPLAY_PORT=8029
```

### Installer le conteneur
Vous pouvez créer votre conteneur.
```
$ ./install.sh
```

### Modifier le fichier d'intallation
Après l'installation, il faudra modifier le contenu du fichier "**install.sh**" :
```
./bin/createProject.sh
#./bin/updateProject.sh
./bin/start.sh
```
Par :
```
#./bin/createProject.sh
./bin/updateProject.sh
./bin/start.sh
```
Si ce n'est pas déjà fait.

### Modifier les versions
> [!WARNING]
> Il est indispensable de le faire pour pouvoir utiliser un conteneur identique des années plus tard. Surtout pour le conteneur qui contient le code.

Sur le projet actuel, on utilise les nouvelles versions ce qui peut poser des problèmes sur le projet par la suite. Il est préférable d'utiliser la version utilisée lors de la création du projet.
<br />[docker nodejs](https://hub.docker.com/_/node/)
<br /><img src="./images/Screenshot_20230914_092538.png" alt="exemple angular server" width="300" height="175"><br />
```
$ ./bin/terminal.sh
# php -v
PHP 8.2.10 (cli) (built: Sep  7 2023 06:04:45) (NTS)
# symfony version
Symfony CLI version 5.5.8 (c) 2021-2023 Fabien Potencier
# composer -V
Composer version 2.6.3 2023-09-15 09:38:21
```
Dand le fichier "**.docker/angular/Dockerfile**", remplacé '**latest**' par la bonne version disponible pour docker :
```
FROM node:latest
```
```
FROM node:20.6.1
```

<br />

> [!NOTE]
> Vous n'êtes pas obligé de modifier la version des autres conteneurs.

<br />

Pour connaître la version pour mongodb :
```
$ ./bin/terminal_mongo.sh
# mongod --version
db version v7.0.1
```
Remplacer la version dans le fichier "**.env.example**" :
```
VALUE_SGBD_VERSION=7.0.1
VALUE_MOEXPRESS_VERSION=latest
VALUE_MAILHOG_VERSION=latest
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

## Mini-projet angular
Il y a un mini-projet angular pour vous montrer un exemple, mais vous pouvez le retirer en vidant le dossier "**project**".<br />
> [!WARNING]
> Ne surtout pas supprimer le fichier "**.gitignore**" du dossier "**project**".<br />

Lors de l'installation, il démarre le serveur angular du mini-projet sur '**localhost:4200**' si vous n'avez pas modifié le port (sinon il faut modifier le numéro de port du lien) :
<br /><img src="./images/Screenshot_20230914_092616.png" alt="exemple angular server" width="300" height="175"><br />
Vous pouvez modifier le démarrage de votre projet dans le fichier ".env.example" et aussi dans le fichier ".env" :
```
FOLDER_PROJECT_ANGULAR=projectAngular
```
Quand vous allez redémarrer le pc, il faudra relancer le serveur Nodejs avec la commande :
```
$ ./start.sh
```

### Options pour la création du projet angular
Il est possible de créer un projet avec des options, comme l'utilisation de sass ou less.( [ng new](https://angular.io/cli/new) )<br />
```
$ ./bin/createProject.sh --help
Options:
    --style      The file extension or preprocessor to use for style files.              css | scss | sass | less
```
En ligne de commande :
```
$ ./bin/createProject.sh --style=scss
```
Ou dans le fichier "**install.sh**" :
```
./bin/createProject.sh --style=scss
#./bin/updateProject.sh
./start.sh
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

______composer require symfony/maker-bundle --dev
composer require symfony/mailer
composer require symfony/mailer
symfony console make:controller BrandNewController
composer require symfony/sendgrid-mailer
