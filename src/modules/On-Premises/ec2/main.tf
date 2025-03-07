provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {}

locals {
  region = "us-east-1"

#   vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 2)

  tags = {
    Repository = "https://github.com/terraform-aws-modules/terraform-aws-ec2-instance"
  }
}

################################################################################
# EC2 Module
################################################################################

module "public_ec2_vpc_on_premises" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "On-Premises-Gateway-VPN" 

  ami                         = "ami-0453ec754f44f9a4a"
  instance_type               = "t2.micro"
  # availability_zone           = element(local.azs, 0)
  subnet_id                   = var.public_subnet_on_premises
  vpc_security_group_ids      = [var.sg_on_premises_id]
  associate_public_ip_address = true
  key_name                    = "trinhdat"

  tags = local.tags
}
