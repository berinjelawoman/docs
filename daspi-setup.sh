#"/bin/bash"

echo updating packages
apt update --fix-missing

echo "Starting DasPi setup"
apt install python3-pip adb
/home/ubuntu/DarPi/setup.sh
pip3 install flask-session


echo "Setting up services"

mkdir -p /home/ubuntu/logs
mkdir -p /home/ubuntu/.android
mv adb* /home/ubuntu/.android/

mv ssh-tunnel@.service /etc/systemd/system/
mv ssh-tunnel@blincast /etc/default/

mkdir -p /home/ubuntu/.ssh
mv /home/ubuntu/id_rsa /home/ubuntu/.ssh/

systemctl enable ssh-tunnel@blincast
for f in daspi-services/*; do
    service_name=$(echo $f | cut -d '/' -f 2)
    mv $f /etc/systemd/system/
    systemctl enable $service_name
done

systemctl daemon-reload

echo "Done setting up services"

