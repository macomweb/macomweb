#!/bin/bash

printf "Installing RDP. Please be patient...\n" >&2

# Create a new user.
sudo useradd -m macomweb
sudo adduser macomweb sudo
echo 'macomweb:8426' | sudo chpasswd
sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd

# Install Debian package for NoMachine.
wget https://download.nomachine.com/download/7.8/Linux/nomachine_7.8.1_1_amd64.deb -O nomachine.deb
sudo dpkg -i nomachine.deb
sudo apt-get install -y --fix-broken

# Install Xfce4 desktop environment.
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y xfce4 desktop-base

# Set up the NoMachine session.
echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/nxserver/custom.sessions

# Install Google Chrome.
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O chrome.deb
sudo dpkg -i chrome.deb
sudo apt-get install -y --fix-broken

# Install Nautilus and nano.
sudo apt-get install -y nautilus nano

# Add the user to the NoMachine group.
sudo groupadd nomachine
sudo adduser macomweb nomachine

# Restart the NoMachine service.
sudo systemctl restart nxserver.service

# Copy the Debian Linux command from https://remotedesktop.google.com/headless
printf "\nCheck https://remotedesktop.google.com/headless\n"
printf "Copy the Command Of Debian Linux and paste it here:\n"
read -p "Paste Here: " CRP
sudo su - macomweb -c """$CRP"""

printf "\nSetup Complete\n"

# Print the NoMachine connection information.
ip_address=$(curl -s ifconfig.me)
printf "NoMachine connection information:\n"
printf "  IP address: $ip_address\n"
printf "  Port: 4000\n"
printf "  Username: macomweb\n"
printf "  Password: 8426\n"
