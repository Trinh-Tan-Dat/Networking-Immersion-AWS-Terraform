module "kms" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-kms.git?ref=c2480502618251c45ab8bcf6c57ec37bd08a8370"

  description = "EC2 AutoScaling key usage"
  key_usage   = "ENCRYPT_DECRYPT"

  # Policy
  key_administrators                 = ["arn:aws:iam::211125294364:role/aws-service-role/cks.kms.amazonaws.com/AWSServiceRoleForKeyManagementServiceCustomKeyStores"]
#   key_service_roles_for_autoscaling  = ["arn:aws:iam::012345678901:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"]

  # Aliases
  aliases = ["mycompany/ebs"]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}