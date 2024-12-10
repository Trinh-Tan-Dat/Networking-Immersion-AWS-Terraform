provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {}

locals {
  name   = "ec2"
  region = "us-east-1"

  vpc_cidr = var.vpc_cidr
  azs      = slice(data.aws_availability_zones.available.names, 0, 2)

  tags = {
    Type       = local.name
    Example    = local.name
    Repository = "https://github.com/terraform-aws-modules/terraform-aws-ec2-instance"
  }
}

################################################################################
# EC2 Module
################################################################################

module "private_ec2" {
    source = "terraform-aws-modules/ec2-instance/aws"

    name                        = "ec2-private"
    ami            = "ami-0453ec754f44f9a4a"
    instance_type  = "t2.micro"
    subnet_id      = var.private_subnet_id
    key_name       = "trinhdat"
    vpc_security_group_ids = [var.security_group_id_one]

    associate_public_ip_address = true

    tags = merge(local.tags, { "Type" = "Private EC2" })
}



module "public_ec2" {
    source = "terraform-aws-modules/ec2-instance/aws"

    name                        = "ec2-public"
    ami            = "ami-0453ec754f44f9a4a"
    instance_type  = "t2.micro"
    subnet_id      = var.public_subnet_id
    key_name       = "trinhdat"
    vpc_security_group_ids = [var.security_group_id_two]

    associate_public_ip_address = true

    tags = merge(local.tags, { "Type" = "Public EC2" })
}

