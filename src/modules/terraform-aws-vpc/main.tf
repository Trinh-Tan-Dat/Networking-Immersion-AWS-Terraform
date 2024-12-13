provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {}

locals {
  region = "us-east-1"

  vpc_cidrA = "10.0.0.0/16"
  vpc_cidrB = "10.1.0.0/16"

  azs      = slice(data.aws_availability_zones.available.names, 0, 2)

  tags = {
    GithubRepo = "terraform-aws-vpc"
    GithubOrg  = "terraform-aws-modules"
  }
}


resource "aws_route" "vpcA_to_vpcB" {
  route_table_id         = module.vpcA.private_route_table_ids[0]
  destination_cidr_block = "10.1.0.0/16"
  transit_gateway_id     = var.transit_gateway_id
}


resource "aws_route" "vpcB_to_vpcA" {
  route_table_id         = module.vpcB.private_route_table_ids[0]
  destination_cidr_block = "10.0.0.0/16"
  transit_gateway_id     = var.transit_gateway_id
}


################################################################################
# VPC Module
################################################################################

module "vpcA" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpcA"
  cidr = local.vpc_cidrA

  azs                 = local.azs
  private_subnets     = [for k, v in local.azs : cidrsubnet(local.vpc_cidrA, 8, k)]
  public_subnets      = [for k, v in local.azs : cidrsubnet(local.vpc_cidrA, 8, k + 4)]

  create_database_subnet_route_table    = true
  create_elasticache_subnet_route_table = true
  create_redshift_subnet_route_table    = true

  single_nat_gateway = true
  enable_nat_gateway = true

  tags = local.tags
}


module "vpcB" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpcB"
  cidr = local.vpc_cidrB

  azs                 = local.azs
  private_subnets     = [for k, v in local.azs : cidrsubnet(local.vpc_cidrB, 8, k)]
  public_subnets      = [for k, v in local.azs : cidrsubnet(local.vpc_cidrB, 8, k + 4)]

  create_database_subnet_route_table    = true
  create_elasticache_subnet_route_table = true
  create_redshift_subnet_route_table    = true

  single_nat_gateway = true
  enable_nat_gateway = true

  tags = local.tags
}