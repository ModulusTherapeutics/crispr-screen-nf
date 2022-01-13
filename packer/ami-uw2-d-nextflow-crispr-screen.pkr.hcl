# This file was autogenerated by the 'packer hcl2_upgrade' command. We
# recommend double checking that everything is correct before going forward. We
# also recommend treating this file as disposable. The HCL2 blocks in this
# file can be moved to other files. For example, the variable blocks could be
# moved to their own 'variables.pkr.hcl' file, etc. Those files need to be
# suffixed with '.pkr.hcl' to be visible to Packer. To use multiple files at
# once they also need to be in the same folder. 'packer inspect folder/'
# will describe to you what is in that folder.

# Avoid mixing go templating calls ( for example ```{{ upper(`string`) }}``` )
# and HCL2 calls (for example '${ var.string_value_example }' ). They won't be
# executed together and the outcome will be unknown.

# All generated input variables will be of 'string' type as this is how Packer JSON
# views them; you can change their type later on. Read the variables type
# constraints documentation
# https://www.packer.io/docs/templates/hcl_templates/variables#type-constraints for more info.
variable "ami_name_prefix" {
  type    = string
  default = "ami-uw2-d-nextflow-crispr-screen"
}

variable "aws_access_key" {
  type    = string
  default = ""
}

variable "aws_secret_key" {
  type    = string
  default = ""
}

variable "instance_type" {
  type    = string
  default = "c5.xlarge"
}

variable "source_ami" {
  type    = string
  default = "ami-09f043c293281ecd4"
}

variable "src_folder" {
  type    = string
  default = "packer_files"
}

variable "ssh_username" {
  type    = string
  default = "ec2-user"
}

variable "vpc_id" {
  type    = string
  default = ""
}

variable "vpc_public_sg_id" {
  type    = string
  default = ""
}

variable "vpc_public_sn_id" {
  type    = string
  default = ""
}

variable "vpc_region" {
  type    = string
  default = "us-west-2"
}

variable "working_dir" {
  type    = string
  default = "/home/ec2-user"
}

# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source
# 1 error occurred upgrading the following block:
# unhandled "clean_resource_name" call:
# there is no way to automatically upgrade the "clean_resource_name" call.
# Please manually upgrade to use custom validation rules, `replace(string, substring, replacement)` or `regex_replace(string, substring, replacement)`
# Visit https://packer.io/docs/templates/hcl_templates/variables#custom-validation-rules , https://www.packer.io/docs/templates/hcl_templates/functions/string/replace or https://www.packer.io/docs/templates/hcl_templates/functions/string/regex_replace for more infos.

source "amazon-ebs" "autogenerated_1" {
  access_key                  = "${var.aws_access_key}"
  ami_description             = "AMI to run FredHutch/crispr-screen-nf pipeline."
  # ami_groups                  = ["all"]
  ami_name                    = "${var.ami_name_prefix}-${lower(regex_replace(timestamp(), ":", "-"))}"
  associate_public_ip_address = true
  instance_type               = "${var.instance_type}"
  launch_block_device_mappings {
    delete_on_termination = true
    device_name           = "/dev/sda1"
    volume_size           = "50"
    volume_type           = "gp2"
  }
  region            = "${var.vpc_region}"
  secret_key        = "${var.aws_secret_key}"
  security_group_id = "${var.vpc_public_sg_id}"
  source_ami        = "${var.source_ami}"
  ssh_username      = "${var.ssh_username}"
  subnet_id         = "${var.vpc_public_sn_id}"
  vpc_id            = "${var.vpc_id}"
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  sources = ["source.amazon-ebs.autogenerated_1"]

  provisioner "shell" {
    script = "build_nextflow_crispr_screen.sh"
  }

  provisioner "file" {
    source = "${pathexpand("~/.ssh/ModulusTherapeutics/crispr-screen-nf")}"
    destination = "/home/ec2-user/.ssh/crispr-screen-nf"
  }

  provisioner "shell" {
    script = "deploy_private_github_repo.sh"
  }

  post-processor "manifest" {
    output     = "manifest.json"
    strip_path = true
  }
}
