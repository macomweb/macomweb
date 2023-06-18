#!/bin/bash

# Create a new Compute Engine instance.
gcloud compute instances create rdp-instance --machine-type n1-standard-1

# SSH into the new instance.

# Install the xrdp package.
sudo apt-get update
sudo apt-get install -y xrdp

# Enable the xrdp service.
sudo systemctl enable xrdp

# Start the xrdp service.
sudo systemctl start xrdp

# Create a new user.
sudo adduser cronos --disabled-password --gecos ""

# Set the password for the new user.
echo "cronos:letmein" | sudo chpasswd

# Install a desktop environment.
sudo apt-get install -y ubuntu-desktop
