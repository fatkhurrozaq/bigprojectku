terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws/"


        }
    }
    required_version = ">= 0.14.9"
}

provider "aws" {
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
    profile = "default"
    region = var.region
}

resources "aws_instance" "fatur" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = var.vpc_security_group_ids
    associate_public_ip_address = var.associate_public_ip_address
    count = var.instance_count

    root_block_device {
        volume_type             = var.volume_type
        volume_size             = var.root_volume_size

    }
}

tags = {
    Name = var.tags["name
    purpose = var.tags["purpose"]
    Env = var.tags
}

volume_tags = {
    Name = var.tags["name"]
    Purpose = var.tags["purpose"]
    Env = var.tags["env"]
}

provisioner "remote-exec" {
inline = [
    "sudo apt update && sudo apt upgrade -y",
    "sudo apt install -y nginx"
]

connection {
host = self.public_ip
type = "ssh"
user = "ubuntu"