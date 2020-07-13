#!/usr/bin/env bash


yum --enablerepo=extras install epel-release -y

yum install python-pip wget unzip gcc python-devel libyaml-devel \
openssl-devel libffi-devel libxml2-devel libxslt-devel puppet -y

pip install --upgrade pip
pip install --upgrade setuptools
pip install virtualenv

virtualenv /etc/.rackspace_heat
. /etc/.rackspace_heat/bin/activate


wget https://github.com/kmcjunk/hotstrapper/archive/staging.zip
unzip staging.zip

python -u hotstrapper-staging/bootstrap/centos/7/hotstrap.py
