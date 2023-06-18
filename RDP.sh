#!/bin/bash

echo "Installing RDP. Please wait..."

# Create a new user.
useradd -m macomweb
adduser macomweb sudo
echo "macomweb:8426" | sudo chpasswd
sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd

# Install Xfce4 desktop environment.
DEBIAN_FRONTEND=noninteractive apt install --assume-yes xfce4 desktop-base

# Download and install NoMachine.
wget https://download.nomachine.com/6.12/Linux/nomachine_6.12.3_1_amd64.deb -O nomachine.deb
sudo apt-get install -y gdebi
sudo gdebi --non-interactive nomachine.deb

# Create the nomachine group if it does not exist.
sudo groupadd nomachine

# Add the user to the nomachine group.
sudo adduser macomweb nomachine

# Restart the NoMachine service.
sudo systemctl restart nomachine.service

# Get the IP address of the instance.
ip_address=$(curl -s ifconfig.me)

# Print the NoMachine connection information.
echo "NoMachine connection information:"
echo "  IP address: $ip_address"
echo "  Port: 4000"
echo "  Username: macomweb"
echo "  Password: 8426"
