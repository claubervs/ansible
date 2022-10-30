#!/usr/bin/env bash

# curl https://raw.githubusercontent.com/claubervs/ansible/main/bootstrap.sh | bash

set -eu

title() {
    local color='\033[1;37m'
    local nc='\033[0m'
    printf "\n${color}$1${nc}\n"
}

title "Install pip and Ansible"
sudo apt update
sudo apt install python3-pip -y
sudo pip3 install ansible

title "Download playbook to ~/install.yml"
curl https://raw.githubusercontent.com/claubervs/ansible/main/bootstrap.yml > ~/bootstrap.yml

title "Provision ansible playbooks"
ansible-playbook -i "localhost," -c local -b ~/bootstrap.yml

title "Install requirements"
ansible-galaxy install -r ~/ansible/requirements.yml --force
# ansible-galaxy install -r requirements.yml --force

title "Provision playbook for root"
ansible-playbook -i "localhost," -c local -b ~/ansible/main.yml

# title "Provision playbook for $(whoami)"
# ansible-playbook -i "localhost," -c local -b /tmp/zsh.yml --extra-vars="zsh_user=$(whoami)"

title "Finished! Please, restart your shell."
echo ""