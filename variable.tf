variable "region" {
  description = "AWS region for resouce"
  type = string
  default = "us-east-1"
  }

variable "vpc_cidr" {
  description = "cidr for vpc"
  type = string
  default = "172.168.0.0/16"
}

variable "pubsub_cidr" {
  description = "cidr for pubsub"
  type = string
  default = "172.168.0.0/24"
}

variable "prisub_cidr" {
  description = "cidr for prisub"
  type = string
  default = "172.168.1.0/24"
}

variable "default_ip" {
  description = "Default ip address"
  type = string
  default = "0.0.0.0/0"
}

variable "source" {
  decription = "sourece for terraform"
  typr = string
  default = "hasicorp/aws"
}

variable "verion" {
  description = "version for terraform"
  type = string
  default = "~> 5.0"
}