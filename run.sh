#!/bin/bash
set -e

o_file="outputs"

# initiating the backend and starting to create the infra
terraform init
terraform apply --auto-approve > $o_file

# getting instance ip from terraform output
nexus_host=$(grep -i public_ip $o_file | cut -d "\"" -f 2)
rm $o_file

# adding host ip to ansible inventory file
echo "[servers]
server1 ansible_host=$nexus_host ansible_user=ubuntu ansible_ssh_private_key_file=../aca-django-keypair.pem" > ansible/hosts.ini

# launching the playbook to install nexus on an instance
cd ./ansible/
ansible-playbook nexusPlaybook.yaml