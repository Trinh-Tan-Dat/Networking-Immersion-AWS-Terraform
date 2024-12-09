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

module "security_group" {
  source = "./modules/terraform-aws-security-group"

  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
}

module "public_ec2" {
  source = "./modules/terraform-aws-ec2"

  public_subnet_id = module.vpc.public_subnet_ids[0]
  security_group_id = module.security_group.security_group_id
  key_name = "trinhdat"
  private_subnet_id = module.vpc.private_subnet_ids[0]
  vpc_cidr = module.vpc.vpc_cidr_block

}

# module "private_ec2" {
#   source = "./modules/terraform-aws-ec2"

#   public_subnet_id = module.vpc.public_subnet_ids[0]
#   security_group_id = module.security_group.security_group_id
#   key_name = "trinhdat"
#   private_subnet_id = module.vpc.private_subnet_ids[0]
# }


# module "key-pair" {
#   source = "./modules/terraform-aws-key-pair"
# }