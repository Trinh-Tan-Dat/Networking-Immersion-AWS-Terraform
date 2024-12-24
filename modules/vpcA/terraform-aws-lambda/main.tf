provider "aws" {
  region = local.region
}

data "aws_caller_identity" "current" {}

locals {
  region = "us-east-1"
  name   = "test secret manager"

  tags = {
    Name       = local.name
    Example    = local.name
    Repository = "https://github.com/terraform-aws-modules/terraform-aws-secrets-manager"
  }
}

################################################################################
# Secrets Manager
################################################################################

module "secrets_manager" {
  source = "terraform-aws-modules/secrets-manager/aws"

  # Secret
  name_prefix             = "test secret manager"
  description             = "Example Secrets Manager secret"
  recovery_window_in_days = 0
  replica = {
    # Can set region as key
    us-east-1 = {}
    # another = {
    #   # Or as attribute
    #   region = "us-west-2"
    # }
  }

  # Policy
#   create_policy       = true
#   block_public_policy = true
#   policy_statements = {
#     read = {
#       sid = "AllowAccountRead"
#       principals = [{
#         type        = "AWS"
#         identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
#       }]
#       actions   = ["secretsmanager:GetSecretValue"]
#       resources = ["*"]
#     }
#   }

  # Version
  create_random_password           = true
  random_password_length           = 64
  random_password_override_special = "!@#$%^&*()_+"

  tags = local.tags
}
