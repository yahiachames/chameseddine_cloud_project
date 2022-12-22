#!/bin/bash

apt install git
curl -sL https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh -o install_nvm.sh
bash install_nvm.sh
export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
git clone https://github.com/yahiachames/ecommerce_frontend_remake.git
cp .env /root/ecommerce_frontend_remake/
cd ecommerce_frontend_remake
nvm install 14
npm install
npm run build
apt-get install nginx python3-certbot-nginx -y
mkdir /var/www/html/react
cp -r /root/ecommerce_frontend_remake/build/* /var/www/html/react/
touch /etc/nginx/conf.d/react.conf
cat /root/react.conf > /etc/nginx/conf.d/react.conf
nginx -t
systemctl restart nginx