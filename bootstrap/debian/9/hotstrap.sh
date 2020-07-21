#!/usr/bin/env bash
set -eux

# Download required packages / removed openssl-dev
apt-get update -y
apt-get install python3-pip wget unzip gcc python-dev libyaml-dev \
libffi-dev libxml2-dev libxslt-dev puppet git -y

# Install required modules
pip3 install --upgrade pip
pip3 install --upgrade setuptools

for module in cryptography==2.5 ansible==2.4.3.0 virtualenv dib-utils "-U decorator"; \
  do pip3 install $module ; \
done


# Create HEAT venv & activate it
virtualenv /etc/.rackspace_heat
. /etc/.rackspace_heat/bin/activate

# Download hotstrap repo
wget https://github.com/kmcjunk/hotstrapper/archive/staging.zip
unzip staging.zip

# Run hotstrap
/etc/.rackspace_heat/bin/python3 -u hotstrapper-staging/bootstrap/debian/9/hotstrap.py

# link venv binaries to global
ln -s /etc/.rackspace_heat/bin/os-refresh-config /usr/bin/os-refresh-config
ln -s /etc/.rackspace_heat/bin/os-apply-config /usr/bin/os-apply-config

# if there is no system unit file, install a local unit
if [ ! -f /usr/lib/systemd/system/os-collect-config.service ]; then

    cat <<EOF >/etc/systemd/system/os-collect-config.service
[Unit]
Description=Collect metadata and run hook commands.

[Service]
ExecStart=/etc/.rackspace_heat/bin/os-collect-config
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

cat <<EOF >/etc/os-collect-config.conf
[DEFAULT]
command=/etc/.rackspace_heat/bin/os-refresh-config
EOF
    fi

# start & enable required service
systemctl enable os-collect-config
systemctl start --no-block os-collect-config

deactivate
