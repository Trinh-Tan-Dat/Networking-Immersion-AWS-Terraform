provider "aws" {
  region = local.region
}

locals {
  region = "us-east-1"

  tags = {
    GithubRepo = "terraform-aws-eks"
    GithubOrg  = "terraform-aws-transit-gateway"
  }
}

################################################################################
# Transit Gateway Module
################################################################################

module "tgw" {
  source = "terraform-aws-modules/transit-gateway/aws"

  name            = "transit-gateway"
  description     = "My TGW shared with several other AWS accounts"

  # When "true" there is no need for RAM resources if using multiple AWS accounts
  enable_auto_accept_shared_attachments = false

  # When "true", allows service discovery through IGMP
  enable_multicast_support = false

  vpc_attachments = {
    vpcA = {
      vpc_id       = var.vpcA_id
      subnet_ids   = var.private_subnets_vpcA

      transit_gateway_default_route_table_association = true
      transit_gateway_default_route_table_propagation = true

      tgw_routes = [
        {
          destination_cidr_block = "10.1.0.0/16"
        }
      ]
      tags = {
        Name = "transit-gateway-vpcA"
      }
    },
    vpcB = {
      vpc_id     = var.vpcB_id
      subnet_ids = var.private_subnets_vpcB

      tgw_routes = [
        {
          destination_cidr_block = "10.0.0.0/16"
        }
      ]
      tags = {
        Name = "transit-gateway-vpcB"
      }
    },
  }

  tags = local.tags
}