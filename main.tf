terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_launch_configuration" "example" {
  image_id        = "ami-830c94e3"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF


# Required when using a launch configuration with an auto scaling group.associate_public_ip_address
# https://www.terraform.io/docs/providers/aws/r/launch_configuration.html

lifecycle {
  create_before_destroy = true
}

}


resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.name
  vpc_zone_identifier = data.aws_subnet_ids.default.ids

  min_size = 2
  max_size = 5

  tag {
    key = "Name"
    value = "terraform-asg-example"
    propagate_at_launch = true

  }
  
}




resource "aws_security_group" "instance" {

  name= var.security_group_name

  ingress {
    from_port = var.server_port
    to_port = var.server_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}

variable "security_group_name" {
  description = "The name of the security group"
  type = string
  default = "terraform-example-instance"

}

output "public_ip" {
  value =  aws_launch_configuration.example.name
  description = "The public IP of the Instance"
  
}


variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type = number
  default = 8080

}

data "aws_vpc" "default" {

}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}