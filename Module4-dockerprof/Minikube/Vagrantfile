Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  
  # Definimos la máquina con Minikube y 4GB de RAM y 3 núcleos
  config.vm.define "minikube" do |minikube|
    minikube.vm.hostname = "minikube"
    minikube.vm.network "private_network", ip: "192.168.57.100"
    minikube.vm.provider "virtualbox" do |v|
      v.name = "minikube"
      v.memory = 4096
      v.cpus = 3
    end
    
    # Instalamos Docker desde los repositorios de Docker
    minikube.vm.provision "shell", inline: <<-SHELL
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
      sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
      sudo apt-get update
      sudo apt-get install -y docker-ce docker-ce-cli containerd.io
      sudo usermod -aG docker vagrant
	  # Instalamos Minikube
      curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
      chmod +x minikube
      sudo mv minikube /usr/local/bin/
      curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
      chmod +x ./kubectl
      sudo mv ./kubectl /usr/bin/kubectl
    SHELL
  end
  
  # Definimos mikroK8s
    config.vm.define "microk8s" do |node|
      node.vm.hostname = "microk8s"
      node.vm.network "private_network", ip: "192.168.57.101"
      node.vm.provider "virtualbox" do |v|
        v.name = "microk8s"
        v.memory = 4096
        v.cpus = 3
      end
      
      # Instalamos Docker desde los repositorios de Docker
      node.vm.provision "shell", inline: <<-SHELL
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
        sudo apt-get update
        sudo apt-get install -y docker-ce docker-ce-cli containerd.io
        sudo usermod -aG docker vagrant
        #instalamos microK8s --- leed  https://ubuntu.com/tutorials/install-a-local-kubernetes-with-microk8s
        sudo snap install microk8s --classic
        sudo ufw allow in on cni0 && sudo ufw allow out on cni0
        sudo ufw default allow routed
        microk8s enable dns 
		microk8s enable dashboard
		microk8s enable storage
		token=$(microk8s kubectl -n kube-system get secret | grep default-token | cut -d " " -f1)
		microk8s kubectl -n kube-system describe secret $token
		sudo usermod -a -G microk8s vagrant
        sudo chown -R vagrant ~/.kube
      SHELL
    end
end
