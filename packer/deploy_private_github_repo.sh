#!/bin/bash
#
# deploy_private_github_repo.sh
#
# Deploy private github repo
# Based on https://stackoverflow.com/questions/26345238/packer-shell-script-provisioner-to-clone-private-repo-auto-launch-ec2-instan
#
# Copyright (C) 2022 Matthew Stone <matthew.stone@modulustherapeutics.com>

ssh-keyscan github.com >> /home/ec2-user/.ssh/known_hosts
eval `ssh-agent`
ssh-agent bash -c \
  'ssh-add /home/ec2-user/.ssh/crispr-screen-nf; git clone git@github.com:ModulusTherapeutics/crispr-screen-nf.git'

cd ${HOME}/crispr-screen-nf
git checkout MS_dev
