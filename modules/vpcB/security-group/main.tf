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

resource "aws_security_group" "service_one_vpcB" {
  name        = "service_one_vpcB"
  vpc_id = var.vpcB_id

  description = "Allow access from service two"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }

}
resource "aws_security_group" "service_two_vpcB" {
  name        = "service_two_vpcB"
  vpc_id = var.vpcB_id

  description = "Allow access from service two"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
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

module "security_group_vpcB" {
  source = "terraform-aws-modules/security-group/aws"

  create_sg         = false
  security_group_id = aws_security_group.service_one_vpcB.id
  ingress_with_source_security_group_id = [
    {
      description              = "http from service two"
      rule                     = "http-80-tcp"
      source_security_group_id = aws_security_group.service_two_vpcB.id
    },
  ]
  vpc_id = var.vpcB_id
}
