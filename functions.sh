source config.sh

function log {
    #DATE=$(date +%x" - "%X)
    DATE=$(date +%d/%m/%Y" - "%H:%M:%S.%N" -")
    echo "$DATE $1" >> $STDOUT_FILE
}

function show {
    if [ "$3" == "nojump" ];
    then
        JUMP="n"
    fi
    
    case $2 in
        information)
            echo -e$JUMP $RBT_INFORMATIONCOLLOR $1 $RBT_DEFAULT #Green
            ;;
        alert)
            echo -e$JUMP $RBT_ALERTCOLLOR $1 $RBT_DEFAULT #Yellow
            ;;
        critical)
            echo -e$JUMP $RBT_CRITICALCOLLOR $1 $RBT_DEFAULT #Red
            ;;
        extrainfo)
            echo -e$JUMP $RBT_EXTRAINFOCOLLOR $1 $RBT_DEFAULT #Blue
            ;;
        *)
            echo -e$JUMP $RBT_DEFAULT $1 $RBT_DEFAULT #Default
            ;;
    esac
    JUMP=""
}

function exec {
    show "$2" "$3" "$4"
    LOG=$($1 2>&1); RC=$?; log "$LOG" #Execute the comand and send stdout and stderr to log
    
    case $RC in
        
        0)
            show "[" "" "nojump"
            show "OK" "information" "nojump"
            show "]"
            ;;
        *)
            show "[" "" "nojump"
            show "FAIL" "critical" "nojump"
            show "]"
            ;;
    esac
}

function write_script {

cat <<-EOF > $TMP_FILE
#!/bin/bash
source config.sh
$1
rm -f $TMP_FILE
EOF
    chmod +x $TMP_FILE
}

function add_user {
    show "User configuration" "extrainfo"
    
    if [ "$RBT_USERNAME" == "" ];
    then
        show "Enter username to create the enviroment to install Ansbile:" "critical" "nojump"
        read RBT_USERNAME
    fi
    
    if [ "$RBT_PASSWORD" == "" ];
    then
        show "Enter $RBT_USERNAME's password:" "critical" "nojump"
        read RBT_USERNAME
    fi
    
    PASSWD=$(echo "$RBT_PASSWORD" | openssl passwd -1 -stdin)
    exec "adduser $RBT_USERNAME -m -s /bin/bash -p $PASSWD" "Adding user" "alert" "nojump"
    exec "usermod -aG wheel $RBT_USERNAME" "Allowing sudo at $RBT_USERNAME" "alert" "nojump"

    #Cleaning user informations in config.sh
    LINE=$(cat -n $CONFIG_FILE | grep RBT_USERNAME= | tr -s '[:space:]' ' ' | cut -d' ' -f2)
    sed -i $LINE'c\RBT_USERNAME=""' $CONFIG_FILE
    LINE=$(cat -n $CONFIG_FILE | grep RBT_PASSWORD= | tr -s '[:space:]' ' ' | cut -d' ' -f2)
    sed -i $LINE'c\RBT_PASSWORD=""' $CONFIG_FILE
}

function show_tittle {
   show "$RBT_TITLE1" "information"
}

function show_credits {
    echo
    show "Login as $RBT_USERNAME and enjoy Ansible!" "information"
    echo
    echo "Credits..."
    /var/lib/snapd/snap/bin/figlet $RBT_FIGLET
    echo $RBT_TITLE2
    echo $RBT_TITLE3
    echo $RBT_TITLE4
}   

function install_ansible {
    show "Getting ansible ready" "extrainfo"
    
    write_script "sudo -u $RBT_USERNAME bash -c \"curl https://bootstrap.pypa.io/get-pip.py -o $RBT_HOME/get-pip.py\""
    exec "source $TMP_FILE" "Copying get-pip.py to the $RBT_USERNAME's environment" "alert" "nojump"
    
    write_script "sudo -u $RBT_USERNAME bash -c \"python $RBT_HOME/get-pip.py --user\""
    exec "source $TMP_FILE" "Installing the last pip version in the $RBT_USERNAME's environment" "alert" "nojump"
    
    write_script "sudo -u $RBT_USERNAME bash -c \"python -m pip install --user ansible\""
    exec "source $TMP_FILE" "Installing ansible in the $RBT_USERNAME's environment" "alert" "nojump"

    write_script "sudo -u $RBT_USERNAME bash -c \"python -m pip install --user paramiko\""
    exec "source $TMP_FILE" "Installing paramiko in the $RBT_USERNAME's environment" "alert" "nojump"

    #sudo -u $RBT_USERNAME bash -c "echo 'PATH="$PATH:$RBT_HOME/.local/bin/"' >> "$RBT_HOME/.bashrc" #Don't need more.
}

function install_winrm {
    show "Getting WinRM module to manage Windows servers ready" "extrainfo"
    write_script "sudo -u $RBT_USERNAME bash -c \"python3 -m pip install pywinrm pywinrm[credssp] requests-credssp dnspython ldap3 pyyaml PyVmomi pyasn1 --user\""
    exec "source $TMP_FILE" "Installing pywinrm in the $RBT_USERNAME's environment" "alert" "nojump"    
}