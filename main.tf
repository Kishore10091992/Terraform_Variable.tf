terraform {
 requried_provide {
  aws = {
   sorece = var.source
   version = var.version
  }
 }
}

provide "aws" {
 region = var.region
}

resouce "aws_vpc" "Tf_var_vpc" {
 cidr_block = var.vpc_cidr

 tags = {
  Name = "Tf_var_vpc"
 }
}

resource "aws_subnet" "Tf_var_pubsub" {
 vpc_id = aws_vpc.Tf_var_vpc.id
 cidr_block = var.pubsub_cidr

 tags {
  Name = "Tf_var_pubsub"
 }
}

resource "aws_subnet" "Tf_var_prisub" {
 vpc_id = var.Tf_var_vpc.id
 cidr_block = var.prisub_cidr

 tags {
  Name = "Tf_var_prisub"
 }
}

resource "aws_internet_gateweay" "Tf_var_IGW" {
 vpc_id = aws.vpc.Tf_var_vpc.id

 tags {
  Name = "Tf_var_igw"
 }
}

resource "aws_route_table" "Tf_var_pubrt" {
 vpc_id = aws_vpc.Tf_var_vpc.id

 route {
  cidr_block = var.default.ip
  gateway = aws_internet_gateweay.Tf_var_IGW.id
 }

 tags {
  Name = "Tf_var_pubrt"
 }
}

resource "aws_route_table" "Tf_var_prirt" {
 vpc_id = aws_vpc.Tf_var_vpc.id

 tags {
  Name = "Tf_var_prirt"
 }
}

resource "aws_route_table_association" "Tf_var_pubrt_ass" {
 subnet_id = aws_subnet.Tf_var_pubsub.id
 route_table_id = aws_route_table.Tf_var.pubrt.id
}

resource "aws_route_table_association" "Tf_var_prirt_ass" {
 subnet_id = aws_subnet.Tf_var_prisub.id
 route_table_id = aws_route_table.Tf_var_prirt.id
}