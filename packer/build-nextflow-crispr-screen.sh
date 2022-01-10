#!/bin/bash -e

# Update packages
sudo yum update -y

# Install Java and Nextflow
sudo yum install -y java-1.8.0-openjdk
curl -fsSL get.nextflow.io | bash

# Install utilities
sudo yum install -y git tmux unzip wget bzip2

# Install and start docker
sudo amazon-linux-extras install -y docker
sudo usermod -a -G docker ec2-user
newgrp docker
sudo systemctl start docker

# Install AWS CLI
# curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
# unzip awscliv2.zip
# rm awscliv2.zip
# sudo ./aws/install
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -f -p $HOME/miniconda
$HOME/miniconda/bin/conda install -c conda-forge -y awscli
rm Miniconda3-latest-Linux-x86_64.sh

# Install crispr-screen pipeline
git clone https://github.com/FredHutch/crispr-screen-nf.git
