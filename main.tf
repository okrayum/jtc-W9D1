# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# This configuration deploys infrastructure on AWS for TechSolutions Inc.
# Resources include EC2 instances, Load Balancer, RDS database, and security configurations.


# SIMULATED INFRASTRUCTURE

# AWS provider configuration
provider "aws" {
  region = "us-west-1"  # Change to your desired region
  
}

# VPC to host TechSolutions Inc resources
resource "aws_vpc" "primary_vpc" {
  cidr_block = "10.0.0.0/16" # Adjust CIDR block as needed

  tags = {
    Name = "Primary VPC"
  }
}

# Subnet for EC2 instances
resource "aws_subnet" "primary_subnet" {
  vpc_id            = aws_vpc.primary_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-1a"

  tags = {
    Name = "Primary Subnet"
  }
}

# EC2 instances
resource "aws_instance" "servers" {
  count         = 2
  ami           = "ami-0827b6c5b977c020e"  # Replace with a valid AMI ID
  instance_type = "t2.micro"               # Adjust instance type as needed
  subnet_id     = aws_subnet.primary_subnet.id

  tags = {
    Name = "Server ${count.index + 1}"
  }
}

# Security group for EC2 instances
resource "aws_security_group" "instance_security_group" {
  vpc_id = aws_vpc.primary_vpc.id

  # Allow inbound HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Instance Security Group"
  }
}