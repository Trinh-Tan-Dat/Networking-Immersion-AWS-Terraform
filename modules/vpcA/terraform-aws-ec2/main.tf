provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "available" {}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "Public EC2 Instance"

  ami                    = "ami-01816d07b1128cd2d"
  instance_type          = "t2.micro"
  key_name               = "trinhdat"
#   monitoring             = true
  vpc_security_group_ids = [var.security_group_id]
  subnet_id              = var.public_subnet
  associate_public_ip_address = true
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
  iam_instance_profile = "LabInstanceProfile"

}

module "ec2_instance_private" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "Private EC2 Instance"

  ami                    = "ami-01816d07b1128cd2d"
  instance_type          = "t2.micro"
  key_name               = "trinhdat"
#   monitoring             = true
  vpc_security_group_ids = [var.security_group_id]
  subnet_id              = var.private_subnet
  associate_public_ip_address = false
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
  iam_instance_profile = "LabInstanceProfile"
}