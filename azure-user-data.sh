#! /bin/bash
sudo apt-get update
sudo apt install aptitude -y
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

# Node.js (v14+)

curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs


# Clone TeslaMate git repository

cd /usr/src

git clone https://github.com/adriankumpf/teslamate.git
cd teslamate

git checkout $(git describe --tags `git rev-list --tags --max-count=1`) # Checkout the latest stable version


# Create PostgreSQL database
sudo touch db_create.sql
sudo chmod 777 db_create.sql

sudo echo "create database teslamate;" >> db_create.sql
sudo echo "create user teslamate with encrypted password 'CrazyS0mmer201602!';" >> db_create.sql
sudo echo "grant all privileges on database teslamate to teslamate;" >> db_create.sql
sudo echo "ALTER USER teslamate WITH SUPERUSER;" >> db_create.sql
sudo echo "\q" >> db_create.sql


sudo -u postgres psql -f db_create.sql

# Compile Elixir Project

sudo mix local.hex --force; mix local.rebar --force

sudo mix deps.get --only prod
sudo npm install --prefix ./assets && npm run deploy --prefix ./assets

sudo MIX_ENV=prod mix do phx.digest, release --overwrite

# Set your system locale
sudo locale-gen en_US.UTF-8
sudo localectl set-locale LANG=en_US.UTF-8

# Starting TeslaMate at boot time

sudo touch /etc/systemd/system/teslamate.service
sudo chmod 777 /etc/systemd/system/teslamate.service

sudo echo "[Unit]" >> /etc/systemd/system/teslamate.service
sudo echo "Description=TeslaMate" >> /etc/systemd/system/teslamate.service
sudo echo "After=network.target" >> /etc/systemd/system/teslamate.service
sudo echo "After=postgresql.service" >> /etc/systemd/system/teslamate.service

sudo echo "[Service]" >> /etc/systemd/system/teslamate.service
sudo echo "Type=simple" >> /etc/systemd/system/teslamate.service
sudo echo "# User=username" >> /etc/systemd/system/teslamate.service
sudo echo "# Group=groupname" >> /etc/systemd/system/teslamate.service

sudo echo "Restart=on-failure" >> /etc/systemd/system/teslamate.service
sudo echo "RestartSec=5" >> /etc/systemd/system/teslamate.service

sudo echo "Environment="HOME=/usr/src/teslamate" >> /etc/systemd/system/teslamate.service
sudo echo "Environment="LANG=en_US.UTF-8" >> /etc/systemd/system/teslamate.service
sudo echo "Environment="LC_CTYPE=en_US.UTF-8" >> /etc/systemd/system/teslamate.service
sudo echo "Environment="TZ=Europe/Berlin" >> /etc/systemd/system/teslamate.service
sudo echo "Environment="PORT=4000" >> /etc/systemd/system/teslamate.service
sudo echo "Environment="DATABASE_USER=teslamate" >> /etc/systemd/system/teslamate.service
sudo echo "Environment="DATABASE_PASS=CrazyS0mmer201602!" >> /etc/systemd/system/teslamate.service
sudo echo "Environment="DATABASE_NAME=teslamate" >> /etc/systemd/system/teslamate.service
sudo echo "Environment="DATABASE_HOST=127.0.0.1" >> /etc/systemd/system/teslamate.service
sudo echo "Environment="MQTT_HOST=127.0.0.1" >> /etc/systemd/system/teslamate.service

sudo echo "WorkingDirectory=/usr/src/teslamate" >> /etc/systemd/system/teslamate.service

sudo echo "ExecStartPre=/usr/src/teslamate/_build/prod/rel/teslamate/bin/teslamate eval "TeslaMate.Release.migrate"" >> /etc/systemd/system/teslamate.service
sudo echo "ExecStart=/usr/src/teslamate/_build/prod/rel/teslamate/bin/teslamate start" >> /etc/systemd/system/teslamate.service
sudo echo "ExecStop=/usr/src/teslamate/_build/prod/rel/teslamate/bin/teslamate stop" >> /etc/systemd/system/teslamate.service

sudo echo "[Install"] >> /etc/systemd/system/teslamate.service
sudo echo "WantedBy=multi-user.target" >> /etc/systemd/system/teslamate.service

# Start service
sudo systemctl start teslamate

# Make it start at boot
sudo systemctl enable teslamate




