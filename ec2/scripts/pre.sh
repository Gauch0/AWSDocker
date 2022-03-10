# This script still requires user to be created on the hostname, please replace or provide ${username} 
# This script was used on AWS EC2 instances, to ensure fairly smooth experience it requires 4GB RAM so choose t2/3.medium or equivalent or assign 4GB per node if using locally with i.e VirtualBox

echo ":::::::::::::::::::^?G##&#####&&###P^::::::::::::::::::::::::::::
::::::::::::::::::~B#&&B#B###BBBB##&J.:::::::::::::::::::::::::::
::::::::::::::::::^P##BBBPPJ??7!JB##&?:::::::::::::::::::::::::::
:::::::::::::::::::~#P?7!^:::^^~7P#&&B^::::::::::::::::::::::::::
::::::::::::::::::::?P?!~^^^^~!!!7YBG?^::::::::::::::::::::::::::
::::::::::::::::::::.!YYY7~!??J7!!7Y7!^::::::::::::::::::::::::::
:::::::::::::::::::::.7J??7~~~~~~!7JY?:::::::::::::::::::::::::::
:::::::::::::::::::^~!77!7?~7!!7777?J^.::::::::::::::::::::::::::
::::::::::::::::^!?JY55J?J5J7~!7!77JJ?~::::::::::::::::::::::::::
::::::::::::^^~7Y5YY5Y55YJJ?77~~!JYJJ7!~:::::::::::::::::::::::::
:::::::::::!Y?J55YY55YYJY55J????YJ7~?7^Y7.:::::::.....:::::::::::
:::::::::::?5YYJYY?J?!^:^!7JYPY?77!~!?5#B!.:...:....:::::::::::::
:::::::::::~?7YY?!~^:::::::::75?77JYPB#B#G^.........::::^::::::::
:::::::::::::^~^^^^^::::^:::.:P#BBB##BBBB#P:.....:...:::^^^::::::
:::::::::::::^!~::~^~::::::::.^B#BBBBBBBBB#J.....::^::::::^^:::::
:::::::::::::^?J!!!~^^::::::::.?#BBBBBBBBBB...:^!7!:::::^^:::::
::::::::::::.^J?~~~~^~:::::.....5#B#BBBBBBBBG:..:7?7~:^:::^^^::::" > index.html

#UPDATES

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl

#DOCKER
curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo usermod -a -G docker ubuntu
sudo systemctl enable docker
cat <<EOF >/etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker

#K8S
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF >/tmp/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo mv /tmp/kubernetes.list /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
sudo systemctl enable kubelet
sudo kubeadm config images pull

cd /home/ubuntu
sudo git clone https://github.com/DevOpsPlayground/Hands-on-with-container-orchestration-using-Docker-Swarm-and-Kubernetes.git container-orchestration-with-Docker-and-Kubernetes
sudo chown -R ubuntu container-orchestration-with-Docker-and-Kubernetes