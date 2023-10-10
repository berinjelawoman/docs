#/bin/bash

SSID=$1
PASSWORD=$2

sudo sed -e "s/<SSID>/$SSID/g" -e "s/<PASSWORD>/$PASSWORD/g" netplan-template.txt > /etc/netplan/50-cloud-init.yaml

sudo netplan apply
ip a
