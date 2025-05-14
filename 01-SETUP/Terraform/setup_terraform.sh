#!/bin/bash

# setup_terraform.sh
# This script checks your Linux distribution and installs Terraform accordingly.
# Supported: Ubuntu, Debian, Amazon Linux, Fedora, CentOS, RHEL

set -e

# Function to detect OS
detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
        OS_LIKE=$ID_LIKE
    else
        echo "Cannot detect OS. /etc/os-release not found."
        exit 1
    fi
}

# Function to check if terraform is installed
check_terraform() {
    if command -v terraform >/dev/null 2>&1; then
        echo "Terraform is already installed: $(terraform version | head -n 1)"
        exit 0
    fi
}

# Function to prompt user for installation
prompt_user() {
    echo "Terraform is not installed on this system."
    read -p "Are you sure you want to install Terraform? (y/n): " yn
    case $yn in
        [Yy]* ) ;;
        * ) echo "Aborting installation."; exit 0;;
    esac
}

# Function to install dependencies
install_dependencies() {
    case "$1" in
        ubuntu|debian)
            sudo apt-get update
            sudo apt-get install -y wget unzip gnupg software-properties-common
            ;;
        amzn|amazon|centos|rhel)
            sudo yum install -y wget unzip
            ;;
        fedora)
            sudo dnf install -y wget unzip
            ;;
        *)
            echo "Unsupported OS: $1"
            exit 1
            ;;
    esac
}

# Function to install terraform
install_terraform() {
    # Add HashiCorp GPG key and repo, then install
    case "$1" in
        ubuntu|debian)
            wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
            echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
            sudo apt-get update
            sudo apt-get install -y terraform
            ;;
        amzn|amazon|centos|rhel)
            sudo yum install -y yum-utils
            sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/$ID/hashicorp.repo
            sudo yum -y install terraform
            ;;
        fedora)
            sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
            sudo dnf -y install terraform
            ;;
        *)
            echo "Unsupported OS: $1"
            exit 1
            ;;
    esac
}

# Main script
detect_os
check_terraform
prompt_user

# Use OS_LIKE for broader detection if needed
if [[ "$OS" == "ubuntu" || "$OS" == "debian" ]]; then
    install_dependencies "$OS"
    install_terraform "$OS"
elif [[ "$OS" == "amzn" || "$OS" == "amazon" || "$OS" == "centos" || "$OS" == "rhel" ]]; then
    install_dependencies "$OS"
    install_terraform "$OS"
elif [[ "$OS" == "fedora" ]]; then
    install_dependencies "$OS"
    install_terraform "$OS"
else
    echo "Your OS ($OS) is not supported by this script."
    exit 1
fi

echo "Terraform installation complete! Version: $(terraform version | head -n 1)"