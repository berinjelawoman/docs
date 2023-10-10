## Configurando servidor

## Configurar Wi-fi
Veja suas interfaces de rede com 
```ls /sys/class/net```
Então configure a interface de rede que deseja com
```sudo vi /etc/netplan/50-cloud-init.yaml```
Seu arquivo provavelmente terá a seguinte cara:
```
network:
    ethernets:
        eth0:
            dhcp4: true
            optional: true
    version: 2
```
Deixe-o da seguinte forma
```
network:
    ethernets:
        eth0:
            dhcp4: true
            optional: true
    version: 2
    wifis:
        wlan0:
            optional: true
            access-points:
                "SSID-NAME-HERE":
                    password: "PASSWORD-HERE"
            dhcp4: true
```
Onde `wlan0` é a interface wifi que estamos configurando. Caso a rede wifi seja aberta utilize a seguinte formatação:
```
    wifis:
        wlan0:
            optional: true
            access-points:
                "SSID-NAME-HERE": {}
            dhcp4: true
```
Então rode 
```
sudo netplan apply
```
Verifique se está conectado com 
```ip a```
Lembre-se que o Raspberry pi 3 tem suporte apenas a redes 2GHz

## Configurar SSH
Instale o openssh server
```sudo apt install openssh-server```
Crie suas chaves
```
sudo ssh-keygen -A
```
Ative e inicie
```
sudo systemctl enable ssh
sudo systemctl start ssh
```

## Instalar pacotes e DasPi
Rode 
```./setup.sh <IP>``` 
onde `<IP>` é o IP de sua caixinha. Termine a instalação com
```
ssh -p $PORT ubuntu@localhost
```
e aceite a fingerprint.
