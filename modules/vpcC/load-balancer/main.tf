provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {}

locals {
  region = "us-east-1"
  name   = "ex-${basename(path.cwd)}"

  azs      = slice(data.aws_availability_zones.available.names, 0, 2)

  tags = {
    Name       = local.name
    Example    = local.name
    Repository = "https://github.com/terraform-aws-modules/terraform-aws-alb"
  }
}

module "nlb" {
  source = "terraform-aws-modules/alb/aws"

  name               = "my-nlb"
  load_balancer_type = "network"
  vpc_id             = var.vpcC_id
  subnets            = [var.vpcC_public_subnets[0], var.vpcC_public_subnets[1]]
  security_groups    = [var.security_groupC_id]
  enable_deletion_protection = false

  listeners = {
    ex-one = {
      port     = 80
      protocol = "TCP"
      forward = {
        target_group_key = "ex-target-one"
      }
    }
  }
  target_groups = {
    ex-target-one = {
      name_prefix            = "t1-"
      protocol               = "TCP"
      port                   = 80
      target_type            = "instance"
      target_id              = var.instance_ids[0]
      connection_termination = true
      preserve_client_ip     = true


      stickiness = {
        type = "source_ip"
      }
      tags = {
        tcp_udp = true
      }
    }
    
  }


  tags = {
    Environment = "Development"
    Project     = "Example"
  }
}



# resource "aws_lb_target_group" "instance-example" {
#   name        = "tf-example-lb-tg"
#   port        = 80
#   protocol    = "TCP"
# #   target_type = "instance"
#   vpc_id      = var.vpcC_id
# }