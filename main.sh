#!/bin/bash

#set -x
#set -v

source functions.sh
source functions_centos8.sh

function main {
    clear
    echo
    show_tittle
    echo
    install_packages
    install_figlet
    add_user
    install_python
    install_ansible
    install_winrm
    show_credits
    echo
}

main

#remover a senha apos usa-la
#chegar a senha e chegar o usuario
#checar sisitema preparar script para debian
