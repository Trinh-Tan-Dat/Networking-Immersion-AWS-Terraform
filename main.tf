// vpc A
module "vpcA" {
  source = "./modules/vpcA/terraform-aws-vpc"
  s3_bucket_id = module.S3-bucket.s3_bucket_id
  security_group_id = module.security_group.security_group_id
  transit_gateway_id = module.transit_gateway.transit_gateway_id
  vpc_peering_connection_id = module.vpc_peering.vpc_peering_connection_id
}

module "security_group" {
  source = "./modules/vpcA/terraform-aws-security-group"
  vpc_id = module.vpcA.vpc_id
}

# module "ec2_instance" {
#   source = "./modules/vpcA/terraform-aws-ec2"
#   security_group_id = module.security_group.security_group_id
#   public_subnet = module.vpcA.public_subnets[0]
#   private_subnet = module.vpcA.private_subnets[0]
# }

// vpc B
module "vpcB" {
  source = "./modules/vpcB/terraform-aws-vpc"
  s3_bucket_id = module.S3-bucket.s3_bucket_id
  security_group_id = module.security_group_vpcB.security_group_id
  transit_gateway_id = module.transit_gateway.transit_gateway_id
}

module "S3-bucket"{
  source = "./modules/vpcB/terraform-aws-s3"
}

# module "KMS" {
#   source = "./modules/vpcB/terraform-aws-kms"
# }

module "security_group_vpcB" {
  source = "./modules/vpcB/terraform-aws-security-group"
  vpc_id = module.vpcB.vpc_id
}

# module "ec2_instance_vpcB" {
#   source = "./modules/vpcB/terraform-aws-ec2"
#   security_group_id = module.security_group_vpcB.security_group_id
#   public_subnet = module.vpcB.public_subnets[0]
#   private_subnet = module.vpcB.private_subnets[0]
# }

/// vpc C
module "vpcC" {
  source = "./modules/vpcC/vpc"
  vpc_peering_connection_id = module.vpc_peering.vpc_peering_connection_id
}

module "security_group_vpcC" {
  source = "./modules/vpcC/security-group"
  vpcC_id = module.vpcC.vpcC_id
}

# module "auto_scaling" {
#   source = "./modules/vpcC/auto-scaling"
#   security_groupC_id = module.security_group_vpcC.security_group_id
#   vpcC_public_subnets = module.vpcC.vpcC_public_subnets
#   vpcC_private_subnets = module.vpcC.vpcC_private_subnets
#   vpcC_id = module.vpcC.vpcC_id
# }
# module "network_load_balancer" {
#   source = "./modules/vpcC/load-balancer"
#   vpcC_id = module.vpcC.vpcC_id
#   vpcC_public_subnets = module.vpcC.vpcC_public_subnets
#   security_groupC_id = module.security_group_vpcC.security_group_id
#   instance_ids = module.auto_scaling.instance_ids
# }

// vpc on prem
module "vpc_on_prem" {
  source = "./modules/on-premises-vpc/terraform-aws-vpc"
  s3_bucket_id = module.S3-bucket.s3_bucket_id
  security_group_id = module.security_group_on_prem.security_group_id
  transit_gateway_id = module.transit_gateway.transit_gateway_id
}

module "security_group_on_prem" {
  source = "./modules/on-premises-vpc/terraform-aws-security-group"
  vpc_id = module.vpc_on_prem.vpc_id
}

# module "ec2_instance_on_prem" {
#   source = "./modules/on-premises-vpc/terraform-aws-ec2"
#   security_group_id = module.security_group_on_prem.security_group_id
#   public_subnet = module.vpc_on_prem.public_subnets[0]
#   private_subnet = module.vpc_on_prem.private_subnets[0]
# }

// transit gateway
module "transit_gateway" {
  source = "./modules/terraform-aws-transit-gateway"
  private_subnets_vpcA = module.vpcA.private_subnets
  private_subnets_vpcB = module.vpcB.private_subnets
  private_subnets_vpc_on_prem = module.vpc_on_prem.private_subnets
  vpcA_id = module.vpcA.vpc_id
  vpcB_id = module.vpcB.vpc_id
  vpc_on_prem_id = module.vpc_on_prem.vpc_id
}

// vpc peering
module "vpc_peering" {
  source = "./modules/terraform-aws-vpc-peering"
  vpcA_id = module.vpcA.vpc_id
  vpcC_id = module.vpcC.vpcC_id
}

// route 53
# module "route_53"{
#   source = "./modules/terraform-aws-route-53"
#   kms_endpoint_dns = module.vpcB.kms_endpoint_dns
#   nlb_dns_name = module.network_load_balancer.nlb_dns_name
# }