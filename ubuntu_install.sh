#!/bin/bash

install_tools() {
    sudo apt-get update
    sudo apt-get install curl

    if ! [ -x "$(command -v git)" ]; then
        sudo apt-get install git
    fi

    if ! [ -x "$(command -v nodejs)" ]; then
        sudo apt-get install nodejs
        sudo apt-get install npm
    fi

    if ! [ -x "$(command -v terminator)" ]; then
        sudo apt-get install terminator
    fi

    if ! [ -x "$(command -v gitkraken)" ]; then
        wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
        dpkg -i gitkraken-amd64.deb

        #libraries about issues on linux
        sudo apt install libcurl3
        sudo ln -s /usr/lib64/libcurl.so.4 /usr/lib64/libcurl-gnutls.so.4
    fi
}

install_sdkman() {
    if [ -x "$SDKMAN_DIR" ]; then
        curl -s "https://get.sdkman.io" | bash && source "$HOME/.sdkman/bin/sdkman-init.sh"
    fi

    sdk install java 9.0.7-zulu
    sdk install maven 3.6.0
    sdk install gradle 4.10.2
    sdk install kotlin 1.2.70
    sdk install springboot 2.1.0.RELEASE
}

install_code() {
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
    sudo apt-get install code
}

install_python3() {
    if ! [ -x "$(which python3)" ]; then
        sudo apt-get install python3.7 && python-pip
    fi
}

install_idea() {
    sudo snap install intellij-idea-community --classic
}

install_angular() {
    if [ -x "$(command -v npm)" ]; then
        npm install -g @angular/cli
    fi
}

install_docker() {
    sudo apt-get remove docker docker-engine docker.io containerd runc
    sudo apt-get update
    sudo apt-get install \
                apt-transport-https \
                ca-certificates \
                gnupg-agent \
                software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository \
               "deb [arch=arm64] https://download.docker.com/linux/ubuntu \
               $(lsb_release -cs) \
               stable"
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io
    sudo docker run hello-world
}

main() {
    install_tools
    install_sdkman
    install_code
    install_python3
    install_idea
    install_angular
    install_docker
}

main
