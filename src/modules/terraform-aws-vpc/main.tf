provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {}

locals {
  name   = "ex-${basename(path.cwd)}"
  region = "us-east-1"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 2)

  public_subnets_cidrs = ["10.0.0.0/24", "10.0.2.0/24"]
  private_subnets_cidrs = ["10.0.1.0/24", "10.0.3.0/24"]

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-vpc"
    GithubOrg  = "terraform-aws-modules"
  }
  
}

################################################################################
# VPC Module
################################################################################

module "vpc" {
  # source = "../../"
  source = "terraform-aws-modules/vpc/aws"


  name = local.name
  cidr = local.vpc_cidr

  azs                 = local.azs
  public_subnets = local.public_subnets_cidrs
  private_subnets = local.private_subnets_cidrs


  single_nat_gateway = true
  enable_nat_gateway = true

  tags = local.tags
}
