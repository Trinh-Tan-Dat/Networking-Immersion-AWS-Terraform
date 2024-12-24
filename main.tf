module "vpcA" {
  source = "./modules/vpcA/terraform-aws-vpc"
  s3_bucket_id = module.S3-bucket.s3_bucket_id
  security_group_id = module.security_group.security_group_id
}

module "S3-bucket"{
  source = "./modules/vpcA/terraform-aws-s3"
}

# module "KMS" {
#   source = "./modules/vpcA/terraform-aws-kms"
# }

module "security_group" {
  source = "./modules/vpcA/terraform-aws-security-group"
  vpc_id = module.vpcA.vpc_id
}

module "ec2_instance" {
  source = "./modules/vpcA/terraform-aws-ec2"
  security_group_id = module.security_group.security_group_id
  public_subnet = module.vpcA.public_subnets[0]
  private_subnet = module.vpcA.private_subnets[0]
}