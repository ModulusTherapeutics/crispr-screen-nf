#!/bin/bash -e
#
# build-nextflow-crispr-screen.sh
#
# Install dependencies for nextflow-crispr-screen AMI
#
# Copyright (C) 2022 Matthew Stone <matthew.stone@modulustherapeutics.com>

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
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -f -p $HOME/miniconda
$HOME/miniconda/bin/conda install -c conda-forge -y awscli
rm Miniconda3-latest-Linux-x86_64.sh
