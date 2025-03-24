Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-24.04"
  config.vm.box_version = "202502.21.0"

  config.vm.define "master" do |master|
    master.vm.hostname = "master"
    master.vm.network "private_network", type: "dhcp"
    master.vm.network "forwarded_port", guest: 8080, host: 8080
    master.vm.provider "virtualbox" do |vb|
      vb.name = "master"
      vb.memory = "4096"
      vb.cpus = 1
    end
    
    master.vm.provision "shell", inline: <<-SHELL
      sudo apt update
      sudo apt install -y openjdk-17-jdk
      curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
      echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
      sudo apt update
      sudo apt install -y jenkins
      sudo systemctl enable jenkins
      sudo systemctl start jenkins
    SHELL
  end

  config.vm.define "nodo1" do |nodo1|
    nodo1.vm.hostname = "nodo1"
    nodo1.vm.network "private_network", type: "dhcp"
    
    nodo1.vm.provider "virtualbox" do |vb|
      vb.name = "nodo1"
      vb.memory = "2048"
      vb.cpus = 2
    end
    
    nodo1.vm.provision "shell", inline: <<-SHELL
      sudo apt update
      sudo apt install -y openjdk-17-jdk
    SHELL
  end
end
