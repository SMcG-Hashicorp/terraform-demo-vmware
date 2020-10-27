#!/bin/sh
set -e
apt-get install -qy unzip curl
export CONSUL_VERSION="1.8.0"
curl -L "https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip" > /tmp/consul.zip
cd /tmp
unzip consul.zip
mv consul /usr/local/bin
chmod 0755 /usr/local/bin/consul
chown root:root /usr/local/bin/consul
consul -autocomplete-install
complete -C /usr/local/bin/consul consul
useradd --system --home /etc/consul.d --shell /bin/false consul
mkdir --parents /var/consul
chown --recursive consul:consul /var/consul

# Setup the configuration
cat <<EOF >/tmp/consul-config
server = false
datacenter = "packet"
data_dir = "/var/consul/data"
bind_addr = "IP_ADDRESS"
client_addr = "127.0.0.1"
log_level = "INFO"
enable_syslog = true
acl_enforce_version_8 = false
enable_local_script_checks = true
EOF
IP_ADDRESS=$(ifconfig ens160 | grep -E -o "(25[0-4]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-4]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-4]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-4]|2[0-4][0-9]|[01]?[0-9][0-9]?)" | head -n 1)
sed -i "s/IP_ADDRESS/$IP_ADDRESS/g" /tmp/consul-config
mkdir --parents /etc/consul.d
mv /tmp/consul-config /etc/consul.d/consul.hcl
chown --recursive consul:consul /etc/consul.d
chmod 640 /etc/consul.d/consul.hcl

# Setup the init script
cat <<EOF >/tmp/systemd
[Unit]
Description="HashiCorp Consul - A service mesh solution"
Documentation=https://www.consul.io/
Requires=network-online.target
After=network-online.target
ConditionFileNotEmpty=/etc/consul.d/consul.hcl

[Service]
Type=notify
User=consul
Group=consul
PIDFile=/var/run/consul/consul.pid
PermissionsStartOnly=true
ExecStartPre=-/bin/mkdir -p /var/run/consul
ExecStartPre=/bin/chown -R consul:consul /var/run/consul
ExecStart=/usr/local/bin/consul agent \
    -config-dir=/etc/consul.d/ \
    -pid-file=/var/run/consul/consul.pid
ExecReload=/bin/kill -HUP $MAINPID
KillMode=process
KillSignal=SIGTERM
Restart=on-failure
RestartSec=42s
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF

mv /tmp/systemd /etc/systemd/system/consul.service
chmod 0664 /etc/systemd/system/consul.service

mkdir -pm 0755 /var/consul/data

# Start Consul
systemctl enable consul
systemctl start consul

# Load bash profile
echo "export VAULT_ADDR=https://vault.assareh.com:8200" >> /home/hashicorp/.profile
