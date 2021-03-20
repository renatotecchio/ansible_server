#!/bin/bash
# Debug mode -xv

#Install necessarious packages
sudo yum install net-tools -y

OS_NAME=$(cat /etc/[A-Za-z]*[_-][rv]e[lr]* | grep PRETTY_NAME= | cut -d'=' -f2 | sed 's/"//g')

#Distribuitions
OS_DIST[0]=RedHat
OS_DIST[1]=CentOS
OS_DIST[2]=Debian
OS_DIST[3]=Ubuntu


for (( i=0; i<${#OS_DIST[@]}; i++ ))
do
# A mesma variável porém sem o "-", caso a conter  
VAR=$(echo $OS_NAME | sed "s/${OS_DIST[$i]}//g")

# Se os comprimentos forem diferentes então:
if [ "${#OS_NAME}" -ne "${#VAR}" ]
then
    OS_ID=$i
fi
done

echo $OS_ID

echo -n Seus sistema é ${OS_DIST[$OS_ID]};
echo lalalal 

GATEWAY_INTERFACE=$(route | grep default | tr -s '[:space:]' ' ' | cut -d ' ' -f 8 )
NETWORK_INTERFACES_STRING=$(ip a | grep BROADCAST | cut -d ':' -f 2 | sed 's/ //g' > .nis.txt)

i=0

NETWORK_INTERFACES=()
while read line; do
    NETWORK_INTERFACES[$i]=$line
    i=$(($i+1))
done < .nis.txt

#IFS=' ' read -r -a NETWORK_INTERFACES <<< $NETWORK_INTERFACES_STRING 

#echo $GATEWAY_INTERFACE

echo ${NETWORK_INTERFACES[0]}
echo ${NETWORK_INTERFACES[1]}
#echo ${NETWORK_INTERFACES[2]}
#echo ${NETWORK_INTERFACES[3]}
#echo "${NETWORK_INTERFACES[@]}"

#1) descobrir a interface de rede corretamente
#2) descomentar a interface de rede corretamente
#3) criar novo usuario
#4) criar chave rsa
#5) instlar o ansible no usuario


