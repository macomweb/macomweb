#!/bin/bash

# Create a new Compute Engine instance.
gcloud compute instances create rdp-instance --machine-type n1-standard-1
gcloud config set project rdp

# Install the xrdp package.
sudo apt-get update
sudo apt-get install -y xrdp

# Enable the xrdp service.
sudo systemctl enable xrdp

# Start the xrdp service.
sudo systemctl start xrdp

# Create a new user.
sudo useradd -m -d /home/user user

# Set the password for the new user.
sudo passwd user

# Install a desktop environment.
if sudo apt-get install -y ubuntu-desktop; then
  echo "Ubuntu Desktop environment successfully installed."
else
  echo "Unable to locate ubuntu-desktop package. Installing alternative desktop environment."
  sudo apt-get install -y xfce4
fi

# Get the IP address of the instance.
ip_address=$(gcloud compute instances describe rdp-instance --format='value(networkInterfaces[0].accessConfigs[0].natIp)')

# Get the port of the RDP service.
port=$(sudo cat /etc/xrdp/xrdp.ini | grep -Po 'Listen\s+=\s+(\d+)')

# Print the IP address and port to the user.
echo "The IP address of the RDP instance is $ip_address."
echo "The port of the RDP service is $port."
