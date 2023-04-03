#!/bin/bash
yum -y update
yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
systemctl start amazon-ssm-agent
amazon-linux-extras enable ansible2
yum install -y ansible git curl wget tar


#____________________________________node exporter
# Download Node Exporter
curl -LO https://github.com/prometheus/node_exporter/releases/download/v1.2.2/node_exporter-1.2.2.linux-amd64.tar.gz
# Extract the tar file
tar xvf node_exporter-1.2.2.linux-amd64.tar.gz
# Move node_exporter to /usr/local/bin
mv node_exporter-1.2.2.linux-amd64/node_exporter /usr/local/bin/
# Create a systemd service file for Node Exporter
cat <<EOF | tee /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter

[Service]
User=ec2-user
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=default.target
EOF
# Reload systemd daemon
systemctl daemon-reload
# Enable and start the service
systemctl enable node_exporter
systemctl start node_exporter


#____________________________________prometheus
sudo useradd --no-create-home --shell /bin/false prometheus
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus
# Downloading Prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.40.6/prometheus-2.40.6.linux-amd64.tar.gz
sudo tar xvf prometheus-2.40.6.linux-amd64.tar.gz
# Copy binaries file
sudo cp prometheus-2.40.6.linux-amd64/prometheus /usr/local/bin/
sudo cp prometheus-2.40.6.linux-amd64/promtool /usr/local/bin/
# Set user and group ownership to prometheus user
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool
# Copy console and console libraries
sudo cp -r prometheus-2.40.6.linux-amd64/consoles /etc/prometheus
sudo cp -r prometheus-2.40.6.linux-amd64/console_libraries /etc/prometheus
# Set user and group ownership to prometheus user
sudo chown -R prometheus:prometheus /etc/prometheus/consoles
sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries
# Delete downloaded file
sudo rm -rf prometheus-2.40.6.linux-amd64.tar.gz prometheus-2.40.6.linux-amd64

# ===============Configure Prometheus===============
cat <<EOF | sudo tee /etc/prometheus/prometheus.yml
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'node-exporter-v1'
    static_configs:
      - targets: ['localhost:9100']

  - job_name: 'all servers'
    metrics_path: '/metrics'
    scheme: 'http'
    ec2_sd_configs:
      - region: 'eu-west-1'
        port: 9100
    relabel_configs:
      - source_labels: [__meta_ec2_instance_state]
        separator: ;
        regex: running
        replacement: "$1"
        action: keep

EOF

# Set user and group ownership to prometheus user
sudo chown prometheus:prometheus /etc/prometheus/prometheus.yml

# ===============Create service for prometheus===============
cat <<EOF | sudo tee /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target
[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus

#____________________________________nginx
sudo yum install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx

#____________________________________grafana
sudo yum install -y apt-transport-https
sudo yum install -y software-properties-common wget
sudo wget -q -O /usr/share/keyrings/grafana.key https://packages.grafana.com/gpg.key
echo "deb [signed-by=/usr/share/keyrings/grafana.key] https://packages.grafana.com/oss/deb stable main" | tee -a /etc/apt/sources.list.d/grafana.list

sudo yum update
sudo apt install -y grafana

sudo systemctl daemon-reload
sudo systemctl start grafana-server
sudo systemctl enable grafana-server
