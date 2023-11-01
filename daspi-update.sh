IP=$1
PORT=$2

echo sending DasPi
cd $HOME/git/DarPi
git ls-tree -r main --name-only | tar -T - -cf - | ssh -p $PORT ubuntu@$IP "mkdir -p DarPi && tar -C DarPi -xvf -"
ssh -t -p $PORT ubuntu@$IP "sudo systemctl daemon-reload"
