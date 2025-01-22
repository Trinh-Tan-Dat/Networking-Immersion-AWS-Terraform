provider "aws" {
  region = "us-east-1"
}

#############################################################
# Data sources to get VPC and default security group details
#############################################################
data "aws_vpc" "default" {
  default = true
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.default.id
}

########################################################
# Create SGs
########################################################

resource "aws_security_group" "service_one" {
  name        = "service_one"
  vpc_id = var.vpc_id

  description = "Allow access from service two"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  egress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  egress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
    ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "service_two" {
  name        = "service_two"
  vpc_id = var.vpc_id

  description = "Allow access from service one"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  egress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  egress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
    ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

########################################################
# Add SG rules
########################################################

module "rules_one" {
  source = "terraform-aws-modules/security-group/aws"

  create_sg         = false
  security_group_id = aws_security_group.service_one.id
  ingress_with_source_security_group_id = [
    {
      description              = "http from service two"
      rule                     = "http-80-tcp"
      source_security_group_id = aws_security_group.service_two.id
    },
  ]
  vpc_id = var.vpc_id
}

module "rules_two" {
  source = "terraform-aws-modules/security-group/aws"
  vpc_id = var.vpc_id

  create_sg         = false
  security_group_id = aws_security_group.service_two.id
  ingress_with_source_security_group_id = [
    {
      description              = "http from service one"
      rule                     = "http-80-tcp"
      source_security_group_id = aws_security_group.service_one.id
    },
  ]

}