#!/bin/bash
echo "127.0.0.1 $(hostname)" | sudo tee -a /etc/hosts
echo "LC_ALL=en_US.UTF-8" | sudo tee -a /etc/environment
source /etc/environment

sudo apt-get install python
sudo 

sudo git clone https://github.com/openstack/openstack-ansible \
  /opt/openstack-ansible
cd /opt/openstack-ansible

sudo git checkout 13.1.0

sudo scripts/bootstrap-ansible.sh
sudo scripts/bootstrap-aio.sh
sudo scripts/run-playbooks.sh
