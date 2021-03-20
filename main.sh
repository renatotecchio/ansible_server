#!/bin/bash

#Debug mode
#set -xv

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

#permitir entrada do usuario e senha na funcao main
#nao deixar o usuario em branco
#validar complexidade na senha
#criar funcao para o debian
