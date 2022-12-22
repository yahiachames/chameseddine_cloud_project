#!/bin/bash
cd /
mkdir app
cd /app
apt install -y git
git clone -b master https://github.com/yahiachames/ecommerce_back.git 
cd ecommerce_back
cp ~/.env /app/ecommerce_back/
apt update
apt-get -y install python3-pip && apt-get -y install python3-venv && apt-get install python3-dev libmysqlclient-dev
apt-get install -y apt-utils vim curl apache2 apache2-utils
apt-get -y install libapache2-mod-wsgi-py3
apt-get install python-dev default-libmysqlclient-dev
sudo apt install libjpeg-dev zlib1g-dev
python3 -m venv venv
venv/bin/pip install -r requirements.txt
cp django_project.conf /etc/apache2/sites-available/
a2ensite django_project 
a2dissite 000-default.conf
a2enmod rewrite ssl
venv/bin/python3 manage.py migrate
venv/bin/python3 manage.py collectstatic
systemctl restart apache2

