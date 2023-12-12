#!/bin/bash
sudo apt update
sudo apt upgrade -y

echo "Installing AWS CLI"
sudo apt install awscli -y

sudo rm /usr/bin/kubectl
sudo curl -LO "https://dl.k8s.io/release/v1.22.0/bin/linux/amd64/kubectl"
sudo chmod +x kubectl
sudo mv kubectl /usr/bin/
kubectl version --client

echo "Installing ekctl"
# Download EKS CLI https://github.com/weaveworks/eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
export PATH=$PATH:/usr/local/bin
echo 'export PATH=$PATH:/usr/local/bin' >> ~/.bashrc
eksctl version

echo "Installing docker"
sudo snap install docker

echo "Installing terraform "
sudo apt-get install terraform

echo "Installing Helm"
wget https://get.helm.sh/helm-v3.7.1-linux-386.tar.gz
tar -zxvf helm-v3.7.1-linux-386.tar.gz
sudo mv linux-386/helm /usr/local/bin/helm
chmod +x /usr/local/bin/helm
helm version