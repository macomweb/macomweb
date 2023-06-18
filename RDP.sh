#!/bin/bash

echo "Installing RDP. Please be patient..."

# Create a new user.
useradd -m macomweb
adduser macomweb sudo
echo "macomweb:8426" | chpasswd
sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd

# Install Chrome Remote Desktop.
apt-get update
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
dpkg -i chrome-remote-desktop_current_amd64.deb
apt-get install -y --fix-broken

# Install Xfce4 desktop environment.
DEBIAN_FRONTEND=noninteractive apt-get install -y xfce4 desktop-base

# Set up the Chrome Remote Desktop session.
echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session
apt-get install -y xscreensaver
systemctl disable lightdm.service

# Install Google Chrome.
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb
apt-get install -y --fix-broken

# Install Nautilus and nano.
apt-get install -y nautilus nano

# Install NoMachine server.
wget https://download.nomachine.com/download/7.8/Linux/nomachine_7.8.1_1_amd64.deb -O nomachine.deb
dpkg -i nomachine.deb
apt-get install -y --fix-broken

# Create the nomachine group if it does not exist.
groupadd nomachine

# Add the user to the nomachine group.
adduser macomweb nomachine

# Restart the NoMachine service.
systemctl restart nxserver.service

# Get the IP address of the instance.
ip_address=$(curl -s ifconfig.me)

# Print the NoMachine connection information.
echo "NoMachine connection information:"
echo "  IP address: $ip_address"
echo "  Port: 4000"
echo "  Username: macomweb"
echo "  Password: 8426"
