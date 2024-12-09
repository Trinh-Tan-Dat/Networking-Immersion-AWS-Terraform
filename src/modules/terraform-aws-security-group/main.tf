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
  # vpc_id = module.vpc.vpc_id
  vpc_id = var.vpc_id
}

########################################################
# Create SGs
########################################################


resource "aws_security_group" "service_one" {
  name        = "service_one"
  description = "Allow access for services and SSH"
  vpc_id      = var.vpc_id

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

  tags = var.tags
}

resource "aws_security_group" "service_two" {
  name        = "service_two"
  description = "Allow access from service one"
  # vpc_id = module.vpc.vpc_id
  vpc_id = var.vpc_id

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
}


########################################################
# Add SG rules
########################################################


module "security_group" {
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

  # vpc_id = module.vpc.vpc_id
  vpc_id = var.vpc_id
}