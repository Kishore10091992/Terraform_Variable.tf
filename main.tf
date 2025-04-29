terraform {
required_providers{
  aws = {
   source  = "hashicorp/aws"
   version = "~> 5.0"
  }
 }
}

provider "aws" {
 region = var.region
}

resource "aws_vpc" "Tf_var_vpc" {
 cidr_block = var.vpc_cidr

 tags = {
  Name = "Tf_var_vpc"
 }
}

resource "aws_subnet" "Tf_var_pubsub" {
 vpc_id = aws_vpc.Tf_var_vpc.id
 cidr_block = var.pubsub_cidr
 availability_zone = var.Availability zone

 tags = {
  Name = "Tf_var_pubsub"
 }
}

resource "aws_subnet" "Tf_var_prisub" {
 vpc_id = aws_vpc.Tf_var_vpc.id
 cidr_block = var.prisub_cidr
 availability_zone = var.Availability zone

 tags = {
  Name = "Tf_var_prisub"
 }
}

resource "aws_internet_gateway" "Tf_var_IGW" {
 vpc_id = aws_vpc.Tf_var_vpc.id

 tags = {
  Name = "Tf_var_igw"
 }
}

resource "aws_route_table" "Tf_var_pubrt" {
 vpc_id = aws_vpc.Tf_var_vpc.id

 route {
  cidr_block = var.default_ip
  gateway_id    = aws_internet_gateway.Tf_var_IGW.id
 }

 tags = {
  Name = "Tf_var_pubrt"
 }
}

resource "aws_route_table" "Tf_var_prirt" {
 vpc_id = aws_vpc.Tf_var_vpc.id

 tags = {
  Name = "Tf_var_prirt"
 }
}

resource "aws_route_table_association" "Tf_var_pubrt_ass" {
 subnet_id      = aws_subnet.Tf_var_pubsub.id
 route_table_id = aws_route_table.Tf_var_pubrt.id
}

resource "aws_route_table_association" "Tf_var_prirt_ass" {
 subnet_id      = aws_subnet.Tf_var_prisub.id
 route_table_id = aws_route_table.Tf_var_prirt.id
}

resource "aws_key_pair" "Tf_var_keypair" {
 key_name = "Tf_var_kp"
 public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "Tf_var_sg" {
 vpc_id = aws_vpc.Tf_var_vpc.id
  ingress {
   from_port = 0
   to_port = 0
   cidr_blocks = [var.default_ip]
   protocol = -1
  }
   egress {
   from_port = 0
   to_port = 0
   cidr_blocks = [var.default_ip]
   protocol = -1
  }
}

resource "aws_network_interface" "pubint" {
 subnet_id = aws_subnet.Tf_var_pubsub.id
 security_groups = [aws_security_group.Tf_var_sg.id]
}

resource "aws_eip" "Tf_var_eip" {
 domain = "vpc"
 network_interface = aws_network_interface.pubint.id

 tags = {
  Name = "Tf_var_eip"
 }
}

resource "aws_network_interface" "priint" {
 subnet_id = aws_subnet.Tf_var_prisub.id
}

resource "aws_instance" "Tf_var_Ec2_instance" {
 ami = var.AMI_id
 instance_type = var.instance_type
 key_name = aws_key_pair.Tf_var_keypair.key_name

 network_interface {
  device_index = 0
  network_interface_id = aws_network_interface.pubint.id
 }

 network_interface {
  device_index = 1
  network_interface_id = aws_network_interface.priint.id
 }

 user_data = var.user_data

  tags = {
   Name = "Tf_var_Ec2_instance"
  }
}
