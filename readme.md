# Sujet  :

création d'une plateforme E-commerce full stack react ,django et phpMyAdmin pour maintenir la base de données MySQL sur un réseau privé cloud Scaleway et une passerelle vers ssh et l'interface utilisateur en utilisant terraform et scaleway 

## Composants Software :

- Serveur back-end pour l'E-commerce  : un serveur django pour fourninr les Api des produits
- interface utilisateur pour l'E-commerce : un front-end ReactJS pour afficher les produits
- interface utilisateur pour MySQL : un interface utilisateur phpMyAdmin pour manipuler la base de données MySQL
- une base de données MySQL



## Composants Hardware:

### instances : 

- une instance de serveur Back-end
- une instance de serveur pour le Front-end
- une instance de serveur pour phpMyAdmin
- une instance de base de données pour MySQL 
### réseau :
- un réseau privé
- une pasrelle
- DHCP
- NAT
## Architecture réseau:

![alt Architecture réseau](https://i.postimg.cc/1XnRCyNb/documentation-projet-cloud-drawio.png)


- un accés sur le port 3333 pour le l'interface  du serveur Back-end
- un accés sur le port 2221 pour l'SSH du serveur backend
- un accés sur le port 8080 pour l'interface de serveur phpMyAdmin
- un accés sur le port 2222 pour l'SSH de serveur phpMyAdmin
- un accés sur le port 3000 pour l'interface utilisateur Front-end 
- un accés sur le port 2222 pour l'SSH pour le serveur du Front-end 
- il n'y a pas d'accès direct à la base de données MySQL



## Déploiement
### Hardware :
- accéder au dossier du deploy_terraform_scaleway
- executer en terminal la commande "make apply" et inserer votre access_key et secret_key
### Serveur Backend :
- modifier  le variable DB_HOST = l'ip de votre base de données ici notre ip est privé  // fichier .env
- modifier le variable SERVER_HOST = l'ip de votre serveur backend ici c'est l'ip de passerlle   // fichier .env
- transferer les fichiers deploy_back.sh et .env sur l'instance dédiée 
- executer la commande "sh deploy_back.sh"
- accéder a l'interface utilisateur sur le port 3333
### Serveur phpMyAdmin :
- modifier PMA_HOST dans le fichier deploy_mysql.sh et ajouter l'ip de votre base de données ici l'ip est privé 
- transférer les fichier deploy_mysql.sh et install_docker.sh sur l'instance dédiée 
- executer la commande "sh deploy_mysql.sh"
- accéder a l'interface utilisateur sur le port 8080 
### serveur Front-end :
- modifier le variable REACT_APP_API_KEY=l'ip de votre serveur back end ici l'ip est privé , // fichier .env
- modifier le variable server_name ici l'ip est celui de passerelle // fichier react.conf
- transférer les fichier .env,react.conf et deploy_ecommerce_front.sh  sur l'instance dédiée 
- executer la commande "sh deploy_ecommerce_front.sh"
- acceder a l'interface utilisateur sur le port 3000


