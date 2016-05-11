#!/bin/bash
echo "127.0.0.1 $(hostname)" | sudo tee -a /etc/hosts
echo "LC_ALL=en_US.UTF-8" | sudo tee -a /etc/environment
source /etc/environment

sudo apt-get install -y python git

sudo git clone https://github.com/openstack/openstack-ansible \
    /opt/openstack-ansible
cd /opt/openstack-ansible

sudo git checkout 13.1.0

sudo scripts/bootstrap-ansible.sh
sudo scripts/bootstrap-aio.sh
sudo scripts/run-playbooks.sh

# Setup iptables rules for Horizon forwarding
sudo iptables -A FORWARD -i eth0 -o eth1 -p tcp --syn --dport 443 -m conntrack --ctstate NEW -j ACCEPT
sudo iptables -A FORWARD -i eth0 -o eth1 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A FORWARD -i eth1 -o eth0 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -P FORWARD DROP

HORIZON_IP=$(sudo lxc-info -n aio1_horizon_container-26dfeeed -iH | tail -n1)
VM_IP=$(ip -f inet -o addr show eth1|cut -d\  -f 7 | cut -d/ -f 1)
sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 443 -j DNAT --to-destination $HORIZON_IP
sudo iptables -t nat -A POSTROUTING -o eth1 -p tcp --dport 443 -d $HORIZON_IP -j SNAT --to-source $VM_IP
