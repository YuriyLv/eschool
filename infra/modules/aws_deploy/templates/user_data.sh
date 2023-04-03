#!/bin/bash
yum -y update
yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
systemctl start amazon-ssm-agent
yum install docker -y
service docker start
usermod -a -G docker ec2-user
chkconfig docker on
echo ${token_registry} | docker login -u ${user_registry} ${ci_registry} --password-stdin
docker run -d ${image}


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
