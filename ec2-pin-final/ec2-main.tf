resource "aws_instance" "app_server" {
  ami                  = var.ami
  instance_type        = var.instance_type
  key_name             = var.key-id
  iam_instance_profile = var.iam_instance_profile
  hibernation          = "false"
  security_groups      = [var.sg-name]
  root_block_device {
    volume_size           = var.volume_size
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }
  user_data       = <<-EOF
                    #!/bin/bash 
                    sudo apt update
                    sudo apt upgrade -y

                    echo "Installing AWS CLI"
                    sudo apt install awscli -y

                    echo "Installing kubectl"
                    curl -LO https://dl.k8s.io/release/v1.20/bin/linux/amd64/kubectl
                    chmod +x ./kubectl
                    mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
                    echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
                    kubectl version --client

                    echo "Installing ekctl"
                    # Download EKS CLI https://github.com/weaveworks/eksctl
                    curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
                    sudo mv /tmp/eksctl /usr/local/bin
                    export PATH=$PATH:/usr/local/bin
                    echo 'export PATH=$PATH:/usr/local/bin' >> ~/.bashrc
                    eksctl version

                    echo "Installing docker"
                    sudo apt update
                    sudo snap install docker

                    echo "Installing terraform "
                    sudo apt-get install terraform

                    echo "Installing Helm"
                    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
                    chmod +x get_helm.sh
                    ./get_helm.sh   
                    EOF 
  tags = {
    Environment = var.tags["env"]
    project     = var.tags["project"]
  }
}