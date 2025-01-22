provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {}

locals {
  name   = "VPC B"
  region = "us-east-1"

  vpc_cidr = "10.1.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 2)

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-vpc"
    GithubOrg  = "terraform-aws-modules"
  }
}

################################################################################
# VPC Module
################################################################################

module "vpcB" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.name
  cidr = local.vpc_cidr

  azs                 = local.azs
  private_subnets     = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  public_subnets      = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 4)]
  database_subnets    = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 8)]

  private_subnet_names = ["Private Subnet One", "Private Subnet Two"]
  # public_subnet_names omitted to show default name generation for all three subnets
  database_subnet_names    = ["DB Subnet One"]

  create_database_subnet_group  = false
  manage_default_network_acl    = false
  manage_default_route_table    = false
  manage_default_security_group = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_vpn_gateway = false

  enable_dhcp_options              = true
  dhcp_options_domain_name         = "service.consul"
  # dhcp_options_domain_name_servers = ["127.0.0.1", "10.10.0.2"]
  dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]

  

  # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
#   vpc_flow_log_iam_role_name            = "vpc-complete-example-role"
#   vpc_flow_log_iam_role_use_name_prefix = false
#   enable_flow_log                       = true
#   create_flow_log_cloudwatch_log_group  = true
#   create_flow_log_cloudwatch_iam_role   = true
#   flow_log_max_aggregation_interval     = 60

#   tags = local.tags

  
}

resource "aws_route" "vpcB_to_vpcA" {
  route_table_id         = module.vpcB.private_route_table_ids[0]
  destination_cidr_block = "10.0.0.0/16"
  transit_gateway_id     = var.transit_gateway_id
}
resource "aws_route" "vpcBPub_to_vpcA" {
  route_table_id         = module.vpcB.public_route_table_ids[0]
  destination_cidr_block = "10.0.0.0/16"
  transit_gateway_id     = var.transit_gateway_id
}


resource "aws_vpc_endpoint" "s3_gateway" {
  vpc_id = module.vpcB.vpc_id
  service_name = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Gateway"
  tags = {
    Environment = "test"
    Name        = "s3-gateway-vpc-endpoint"
  }
  route_table_ids = module.vpcB.private_route_table_ids
  
  
}

resource "aws_vpc_endpoint" "s3_interface" {
  vpc_id = module.vpcB.vpc_id
  service_name      = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    var.security_group_id,
  ]

  private_dns_enabled = true
  subnet_ids = module.vpcB.private_subnets
  tags = {
    Environment = "test"
    Name        = "s3-interface-vpc-endpoint"
  }
}

resource "aws_vpc_endpoint" "kms_interface" {
  vpc_id = module.vpcB.vpc_id
  service_name      = "com.amazonaws.us-east-1.kms"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    var.security_group_id,
  ]
  subnet_ids = module.vpcB.private_subnets
  private_dns_enabled = true
    tags = {
    Environment = "test"
    Name        = "kms-interface-vpc-endpoint"
  }
}