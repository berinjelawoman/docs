#!/bin/bash

IP=$1

CONFIG_FILE="ssh-tunnel@blincast"
SERVER_PORT=$(( $(tail -n 1 used-ports.txt) + 1 ))
DASPI_PORT=$(( $(tail -n 1 used-ports.txt) + 2 ))

if [[ $SERVER_PORT > 65534 ]]; then
    echo "Port limit reached"
    exit 1
fi


echo $SERVER_PORT >> used-ports.txt
echo $DASPI_PORT >> used-ports.txt

echo sending files

sed "s/<PORT>/$SERVER_PORT/g" ssh-tunnel.config > $CONFIG_FILE
sed -i "s/<DASPIPORT>/$DASPI_PORT/g" $CONFIG_FILE

echo sending DasPi
cd $HOME/git/DarPi
git ls-tree -r main --name-only | tar -T - -cf - | ssh ubuntu@$IP "mkdir -p DarPi && tar -C DarPi -xvf -"

cd -
ssh -t ubuntu@$IP "chmod +x ./daspi-setup.sh && sudo ./daspi-setup.sh"

scp -r $HOME/.android/{adbkey,adbkey.pub,adb.5037} $CONFIG_FILE "ssh-tunnel@.service" "daspi-setup.sh" "daspi-services" "id_rsa" ubuntu@$IP:/home/ubuntu/
echo Installation finished. Tunnel port is $SERVER_PORT. Finish setup with ssh -p $SERVER_PORT ubuntu@localhost and accept the fingerprint
