#!/bin/bash

IP=$1

CONFIG_FILE="ssh-tunnel@blincast"
SERVER_PORT=$2
DASPI_PORT=$3

echo sending files

sed "s/<PORT>/$SERVER_PORT/g" ssh-tunnel.config > $CONFIG_FILE
sed -i "s/<DASPIPORT>/$DASPI_PORT/g" $CONFIG_FILE
scp -P $SERVER_PORT -r $CONFIG_FILE "ssh-tunnel@.service" "daspi-setup.sh" "daspi-services" "id_rsa" ubuntu@$IP:/home/ubuntu/

echo sending DasPi
cd $HOME/git/DarPi
git ls-tree -r main --name-only | tar -T - -cf - | ssh -p $SERVER_PORT ubuntu@$IP "mkdir -p DarPi && tar -C DarPi -xvf -"

cd -
ssh -p $SERVER_PORT -t ubuntu@$IP "chmod +x ./daspi-setup.sh && sudo ./daspi-setup.sh"

echo Installation finished. Tunnel port is $SERVER_PORT. Finish setup with ssh -p $SERVER_PORT ubuntu@localhost and accept the fingerprint
