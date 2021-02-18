# Copyright © 2021 Shell.in.net All rights reserved.
# Licensed under the GNU Lesser General Public License v3.0

yum -y update
yum -y install epel-release wget
yum -y install python3-pip
python3 -m pip install -U pip
python3 -m pip install ansible
ansible-galaxy collection install ansible.posix
ansible-galaxy collection install community.general
wget -q -O - https://shell.in.net/el8/init.yml | ansible-playbook -c local /dev/stdin
