source config.sh

function install_packages {
    show "Getting exentials packages reday" "extrainfo"
    exec "yum update -y" "Operation System Update" "alert" "nojump"
    exec "yum install -y epel-release" "Instaling epel-release" "alert" "nojump"
    exec "yum install curl -y" "Instaling curl" "alert" "nojump"
    #exec "yum install -y git" "Installing git" "alert" "nojump"
}

function install_figlet {
    #ref: https://snapcraft.io/install/figlet/centos
    
    show "Getting figlet ready" "extrainfo"
    exec "yum install -y snapd" "Instaling snapd" "alert" "nojump"
    exec "systemctl enable --now snapd.socket" "Enabling snapd on systemctl" "alert" "nojump"
    exec "ln -s /var/lib/snapd/snap /snap" "Criating simbolic link" "alert" "nojump"
    exec "snap install figlet" "Instaling figlet" "alert" "nojump"
    
    #LOG=$(yum install -y epel-release 2>&1); log "$LOG"
    #ADD_PATH=$(find / -iname figlet | grep snap/bin/figlet)
    #echo 'export PATH=$PATH:'$ADD_PATH > /etc/profile.d/figlet.sh
}

function install_python {
    show "Getting python ready" "extrainfo"
    exec "yum install -y python3-libselinux" "Installing python3-libselinux" "alert" "nojump"
    exec "yum install -y python3-distutils-extra" "Installing python3-distutils-extra" "alert" "nojump"
    exec "yum install -y python38" "Instaling python38" "alert" "nojump"
    exec "alternatives --set python3 /usr/bin/python3.8" "Configuring alternatives to python3" "alert" "nojump"
}