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

 variable "Availability zone" {
  description = "one availability zone"
  type = string
  default = "us-east-1b"
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

variable "AMI_id" {
 description = "AMI id for Ec2"
 type = string
 default = "ami-084568db4383264d4"
}

variable "instance_type" {
 description = "Instance type for Ec2"
 type = string
 default = "t2.micro"
}

variable "user_data" {
 description = "User data for Ec2 instance"
 type = string
 default = "<<-EOF

  sudo yum update -y
  sudo yum install -y httpd
  sudo systemctl start httpd
  sudo systemctl enable httpd
  echo "Hello world from Terraform!" > /var/www/html/index.html
  EOF"
}
