#!/bin/bash

echo "Installing RDP. Please be patient..."

# Install necessary packages for NoMachine.
sudo apt-get update
sudo apt-get install -y xfce4 xfce4-goodies gnome-icon-theme tango-icon-theme tightvncserver

# Install NoMachine.
wget https://download.nomachine.com/download/7.8/Linux/nomachine_7.8.1_1_amd64.deb -O nomachine.deb
sudo dpkg -i nomachine.deb
sudo apt-get install -y --fix-broken

# Set up the XFCE session.
echo "startxfce4" > ~/.xsession

# Configure the VNC server.
vncserver :1 -geometry 1280x800 -depth 24

# Print the connection information.
ip_address=$(hostname -I | cut -d' ' -f1)
echo "NoMachine connection information:"
echo "  IP address: $ip_address"
echo "  Port: 4000"
