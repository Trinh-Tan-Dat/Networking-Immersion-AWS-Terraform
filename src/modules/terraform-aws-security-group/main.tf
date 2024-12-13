provider "aws" {
  region = "us-east-1"
}

#############################################################
# Data sources to get VPC and default security group details
#############################################################
data "aws_vpc" "default" {
  default = true
}

data "aws_security_group" "vpcA" {
  name   = "default"
  vpc_id = var.vpcA_id
}

data "aws_security_group" "vpcB" {
  name   = "default"
  vpc_id = var.vpcB_id
}

########################################################
# Create SGs
########################################################

resource "aws_security_group" "service_one_vpcA" {
  name        = "service_one_vpcA"
  description = "Allow access from service two"
  vpc_id = var.vpcA_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from all IPs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"] # Allow ICMP (Ping) from all IPs
  }

}

resource "aws_security_group" "service_two_vpcA" {
  name        = "service_two_vpcA"
  description = "Allow access from service one"
  vpc_id = var.vpcA_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from all IPs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"] # Allow ICMP (Ping) from all IPs
  }

}

resource "aws_security_group" "service_one_vpcB" {
  name        = "service_one_vpcB"
  description = "Allow access from service two"
  vpc_id = var.vpcB_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from all IPs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"] # Allow ICMP (Ping) from all IPs
  }

}

resource "aws_security_group" "service_two_vpcB" {
  name        = "service_two_vpcB"
  vpc_id = var.vpcB_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from all IPs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
  description = "Allow access from service one"
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"] # Allow ICMP (Ping) from all IPs
  }
}

########################################################
# Add SG rules
########################################################

module "sg_vpcA" {
  source = "terraform-aws-modules/security-group/aws"
  vpc_id = var.vpcA_id
  create_sg         = false
  security_group_id = aws_security_group.service_one_vpcA.id
  ingress_with_source_security_group_id = [
    {
      description              = "http from service two"
      rule                     = "http-80-tcp"
      source_security_group_id = aws_security_group.service_two_vpcA.id
    },
  ]
}

module "sg_vpcB" {
  source = "terraform-aws-modules/security-group/aws"
  vpc_id = var.vpcB_id
  create_sg         = false
  security_group_id = aws_security_group.service_one_vpcB.id
  ingress_with_source_security_group_id = [
    {
      description              = "http from service one"
      rule                     = "http-80-tcp"
      source_security_group_id = aws_security_group.service_two_vpcB.id
    },
  ]
}