#! /bin/bash

# Add Stackdriver Monitoring repo
curl -sSO https://dl.google.com/cloudagents/add-monitoring-agent-repo.sh
bash add-monitoring-agent-repo.sh

# Install wget
apt update
apt install wget -y

# Install Stackdriver Monitoring agent
apt-get install stackdriver-agent -y
service stackdriver-agent start

# Install Stackdriver Logging agent
curl -sSO https://dl.google.com/cloudagents/install-logging-agent.sh
bash install-logging-agent.sh

# Download Caddy
wget -O /usr/local/bin/caddy https://github.com/caddyserver/caddy/releases/download/v2.0.0-beta.15/caddy2_beta15_linux_amd64
chmod +x /usr/local/bin/caddy

# Copy Caddyfile
mkdir -p /etc/caddy
gsutil cp gs://gears-deploy/caddy/prod/Caddyfile /etc/caddy

# Copy templates
mkdir -p /var/lib/caddy
gsutil cp -r gs://gears-deploy/caddy/prod/templates/* /var/lib/caddy

# Start Caddy
/usr/local/bin/caddy start --config /etc/caddy/Caddyfile