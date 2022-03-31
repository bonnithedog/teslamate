#! /bin/bash
sudo apt-get update
# sudo apt-get install -y apache2
# sudo systemctl start apache2
# sudo systemctl enable apache2
# echo "<h1>Demo Bootstrapping Azure Virtual Machine</h1>" | sudo tee /var/www/html/index.html

# Install npm

sudo apt-get update
sudo apt-get install -y npm

# Postgres (v12+)

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | sudo tee  /etc/apt/sources.list.d/pgdg.list
sudo apt-get update
sudo apt-get install -y postgresql-12 postgresql-client-12

# Elixir (v1.11+)

wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && sudo dpkg -i erlang-solutions_2.0_all.deb
sudo apt-get update
sudo apt-get install -y elixir esl-erlang

# Grafana (v8.3.4+) & Plugins

sudo apt-get install -y apt-transport-https software-properties-common
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y grafana
sudo systemctl start grafana-server
sudo systemctl enable grafana-server.service # to start Grafana at boot time
# Plugins
sudo grafana-cli plugins install pr0ps-trackmap-panel 2.1.2
sudo grafana-cli plugins install natel-plotly-panel 0.0.7
sudo grafana-cli --pluginUrl https://github.com/panodata/panodata-map-panel/releases/download/0.16.0/panodata-map-panel-0.16.0.zip plugins install grafana-worldmap-panel-ng
sudo systemctl restart grafana-server

# An MQTT Broker (e.g. Mosquitto)

sudo apt-get install -y mosquitto

Node.js (v14+)

curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs


# Clone TeslaMate git repository

cd /usr/src

git clone https://github.com/adriankumpf/teslamate.git
cd teslamate

git checkout $(git describe --tags `git rev-list --tags --max-count=1`) # Checkout the latest stable version


# Create PostgreSQL database
# Manual from here


