#!/bin/bash

sh install_docker.sh
docker pull phpmyadmin
docker run --name phpmyadmin -d -e PMA_HOST=l'ip__base_de_données -e PMA_PORT=3306 -p 8080:80 phpmyadmin
