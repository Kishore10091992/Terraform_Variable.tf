variable "region" {
  description = "AWS region for resource"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  type        = string
  default     = "172.168.0.0/16"
}

variable "availability_zone" {
  description = "One availability zone"
  type        = string
  default     = "us-east-1b"
}

variable "pubsub_cidr" {
  description = "CIDR for public subnet"
  type        = string
  default     = "172.168.0.0/24"
}

variable "prisub_cidr" {
  description = "CIDR for private subnet"
  type        = string
  default     = "172.168.1.0/24"
}

variable "default_ip" {
  description = "Default IP address"
  type        = string
  default     = "0.0.0.0/0"
}

variable "AMI_id" {
  description = "AMI ID for EC2"
  type        = string
  default     = "ami-084568db4383264d4"
}

variable "instance_type" {
  description = "Instance type for EC2"
  type        = string
  default     = "t2.micro"
}

variable "user_data" {
  description = "User data for EC2 instance"
  type        = string
  default     = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y httpd
                systemctl start httpd
                systemctl enable httpd
                echo "Hello world from Terraform!" > /var/www/html/index.html
                EOF
}
