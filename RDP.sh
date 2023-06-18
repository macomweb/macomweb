#!/bin/bash

# Installs Chrome Remote Desktop and NoMachine on a Linux machine.

echo "Installing RDP Be Patience..."

# Create a new user.
useradd -m macomweb
adduser macomweb sudo
echo "macomweb:8426" | sudo chpasswd
sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd

# Install Chrome Remote Desktop.
apt-get update
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo dpkg -i chrome-remote-desktop_current_amd64.deb
apt install --assume-yes --fix-broken

# Install Xfce4 desktop environment.
DEBIAN_FRONTEND=noninteractive apt install --assume-yes xfce4 desktop-base

# Set up the Chrome Remote Desktop session.
echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session
apt install --assume-yes xscreensaver
systemctl disable lightdm.service

# Install Google Chrome.
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
apt install --assume-yes --fix-broken

# Install Nautilus and nano.
apt install nautilus nano -y

# Install NoMachine server.
wget https://download.nomachine.com/free/linux/64/deb -O nomachine.deb
sudo dpkg -i nomachine.deb

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
