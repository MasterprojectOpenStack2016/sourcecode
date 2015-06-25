#!/bin/sh
#
# This is the configuration script for the installation.
# Do not use variable values that stretch over more than one line.
#

###############################################################################
###### passwords

# The default_password variable should never be used directly in a script.
# default_password is the variable that can be changed to change all passwords 
# at once if they are set to default_password.
default_password=aXp7s50

# mysql_password is the password used for the mysql installation and service.
mysql_password=$default_password

# rabbitmq_password is the password used for the rabbit message queue.
rabbitmq_password=$default_password

###############################################################################
###### configuration for download

# downloads_directory is the directory where to download the image files to
downloads_directory='/tmp/openstack_installation/downloads'

# vm_image_url is the url for the image in the vms.
# When you change this also change vm_image_md5_hash and default_login_name.
# I had a look at https://cloud-images.ubuntu.com/trusty/ for the url.
# For the current release you can use https://cloud-images.ubuntu.com/trusty/current/trusty-server-cloudimg-amd64-disk1.img
vm_image_url='https://cloud-images.ubuntu.com/trusty/20150313/trusty-server-cloudimg-amd64-disk1.img'

# vm_image_md5_hash is the md5 hash of the vm image.
# It is used to avoid duplicate downloads.
# If this hash does not fit, the image will be downloaded
# every time the vms are set up.
vm_image_md5_hash=ba8c94999ca0d5052ccc0d4b12b9aca4

# downloaded_vm_image_folder is the folder where the downloaded vm image is 
# saved.
downloaded_vm_image_folder=$downloads_directory/images/vm

###############################################################################
###### configuration for the creation of the vms

# vm_images_directory is the folder where the image files of the virtual
# machines are stored.
# If you change this path be aware that the paths in the xml files in config/vm 
# need to be changed as well.
vm_images_directory='/tmp/openstack_installation/images'

# vm_base_image_name is the name of the downloaded image.
vm_base_image_name='vm.img'

# user_data_cloud_config_file is the configuration file used by could-init.
# See "Create a user-data file" in http://serverascode.com/2014/03/17/trusty-libvirt.html
# There we specify that the password and ssh key are set on the vm.
user_data_cloud_config_file='user-data.cloud-config'
user_data_cloud_config_image='user-data.cloud-config.img'

# authorized_public_key_file_for_access_to_the_vm is the public key that allows
# us to access the vm once it is started.
authorized_public_key_file_for_access_to_the_vm=~/.ssh/id_rsa.pub
authorized_private_key_file_for_access_to_the_vm=~/.ssh/id_rsa

# authorized_password_for_access_to_the_vm is the password that allows us to 
# access the vm once it is started. If the password is empty you can not log in
# with a password.
authorized_password_for_access_to_the_vm=$default_password

###############################################################################
###### network configuration

# test_node_ip_address is the ip address of the controller node in the 
# default network.
test_node_ip_address=192.168.122.100
controller_node_ip_address=192.168.122.100

# default_login_name is the log in name of the ansible user for the vm.
# If you change the image e.g. by changing vm_image_url, consider that this
# variable needs to be changed, too.
default_login_name=ubuntu

###############################################################################
###### ansible configuration

# generated_ansible_roles_directory is the directory where we generate the 
# config role. This role contains all variables defined in this configuration 
# file. Variables can be used in ansible like this: 
#   {{ config.generated_ansible_roles_directory }}
# Do not use spaces in this variable. 
generated_ansible_roles_directory=/etc/ansible/roles

###############################################################################
###### setup to make variables valid

# create the downloads directory
mkdir -p $downloads_directory
mkdir -p $vm_images_directory
vm_base_image_file=$vm_images_directory/$vm_base_image_name

