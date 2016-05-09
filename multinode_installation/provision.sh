#!/bin/bash
echo "127.0.0.1 $(hostname)" | sudo tee -a /etc/hosts
echo "LC_ALL=en_US.UTF-8" | sudo tee -a /etc/environment
source /etc/environment

sudo apt-get install -y python

sudo git clone https://github.com/openstack/openstack-ansible \
    /opt/openstack-ansible
cd /opt/openstack-ansible

sudo git checkout 13.1.0

sudo scripts/bootstrap-ansible.sh
sudo scripts/bootstrap-aio.sh

cd /etc/ansible/roles/openstack_hosts
sudo wget https://github.com/openstack/openstack-ansible-openstack_hosts/commit/ada466cccd8a55f6ed43ad2f3bc75a0a72bdbd77.patch -O fix_openstack_host_kernel_modules.patch
sudo patch -p1 < fix_openstack_host_kernel_modules.patch
sudo rm fix_openstack_host_kernel_modules.patch

sudo cp /etc/ansible/roles/lxc_hosts/vars/ubuntu-14.04.yml \
    /etc/ansible/roles/lxc_hosts/vars/ubuntu.yml

# --skip-tags V-38674 V-38674

cd /opt/openstack-ansible
sudo scripts/run-playbooks.sh
