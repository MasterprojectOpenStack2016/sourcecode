#!/bin/sh



###############################################################################
###### configuration for download

# downloads_directory is the directory where to download the image files to
downloads_directory='/tmp/openstack_installation/downloads'

# vm_image_url is the url for the image in the vms.
# When you change this also change vm_image_md5_hash.
# I had a look at https://cloud-images.ubuntu.com/trusty/ for the url.
# For the current release you can use https://cloud-images.ubuntu.com/trusty/current/trusty-server-cloudimg-amd64-disk1.img
vm_image_url='https://cloud-images.ubuntu.com/trusty/20150614/trusty-server-cloudimg-amd64-disk1.img'

# vm_image_md5_hash is the md5 hash of the vm image.
# It is used to avoid duplicate downloads.
# If this hash does not fit, the image will be downloaded
# every time the vms are set up.
vm_image_md5_hash=86dbf23e4a174c156ad773e6790e1897

###############################################################################
###### configuration for the vms

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
user_data_cloud_config_file='/tmp/openstack_installation/images/user-data.cloud-config'
user_data_cloud_config_image='/tmp/openstack_installation/images/user-data.cloud-config.img'

# authorized_public_key_file_for_access_to_the_vm is the public key that allows
# us to access the vm once it is started.
authorized_public_key_file_for_access_to_the_vm=~/.ssh/id_rsa.pub
authorized_private_key_file_for_access_to_the_vm=~/.ssh/id_rsa

# authorized_password_for_access_to_the_vm is the password that allows us to 
# access the vm once it is started. If the password is empty you can not log in
# with a password.
authorized_password_for_access_to_the_vm=

###############################################################################
###### setup to make variables valid

# create the downloads directory
mkdir -p $downloads_directory
mkdir -p $vm_images_directory
vm_base_image_file=$vm_images_directory/$vm_base_image_name
