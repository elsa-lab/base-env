#!/usr/bin/env bash

NETDATA_CONFIG="/etc/netdata/netdata.conf"
NETDATA_PLUGIN_DIS=(
  "diskspace"
  "cgroups"
  "tc"
  "idlejitter"
  "slabinfo"
  "ebpf_process"
  "charts.d"
  "fping"
  "ioping"
  "node.d"
  "python.d"
  "apps"
  "perf"
  "go.d"
)

NGINX_CONFIG="/etc/nginx/sites-available/default"

# update apt repository
sudo apt update

# install nginx and netdata
bash <(curl -Ss https://my-netdata.io/kickstart.sh) \
  --non-interactive \
  --disable-telemetry

# backup default configuration of netdata
sudo cp "${NETDATA_CONFIG}" "${NETDATA_CONFIG}.bak"

# bind netdata to localhost
sudo sed -i "/\[web\]/,/#.*bind to.*/s/#.*bind to.*/bind to = localhost/" "${NETDATA_CONFIG}"

# only allow proc plugin in netdata
for ((i=0; i<${#NETDATA_PLUGIN_DIS[@]}; i++)); do
  sudo sed -i "/\[plugins\]/,/#.*${NETDATA_PLUGIN_DIS[$i]}.*/s/#.*${NETDATA_PLUGIN_DIS[$i]}.*/${NETDATA_PLUGIN_DIS[$i]} = no/" "${NETDATA_CONFIG}"
done

# install nginx
sudo apt install nginx -y

# backup default configuration of nginx
sudo cp "${NGINX_CONFIG}" "${NGINX_CONFIG}.bak"

# config reverse proxy for netdata
echo '
server {
  listen 80 default_server;
  listen [::]:80 default_server;
  root /var/www/html;
  index index.html index.htm index.nginx-debian.html;
  server_name _;
  location / {
    try_files $uri $uri/ =404;
  }
  location /status/ {
    proxy_pass http://localhost:19999/;
  }
}
' | sudo tee "${NGINX_CONFIG}"

# restart services
sudo service netdata restart
sudo service nginx restart
