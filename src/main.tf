provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/terraform-aws-vpc"

  name     = local.name
  vpc_cidr = local.vpc_cidr
  tags     = local.tags
}


locals {
  name     = "vpc"
  vpc_cidr = "10.0.0.0/16"
  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-vpc"
    GithubOrg  = "terraform-aws-modules"
  }
}
