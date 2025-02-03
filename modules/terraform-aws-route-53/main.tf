resource "aws_route53_record" "kms_endpoint_route53" {
  zone_id = "Z059212819I45EN53QUHP"
  name    = "kms_endpoint.trinhdat.id.vn"
  type    = "CNAME"
  ttl     = 300
  weighted_routing_policy {
    weight = 10
  }

  set_identifier = "dev"
  records = [var.kms_endpoint_dns]
}


resource "aws_route53_record" "nlb_dns_route53" {
  zone_id = "Z059212819I45EN53QUHP"
  name    = "nlb.trinhdat.id.vn"
  type    = "CNAME"
  ttl     = 300
  weighted_routing_policy {
    weight = 10
  }

  set_identifier = "dev"
  records = [var.nlb_dns_name]
}




# module "zones" {
#   source  = "terraform-aws-modules/route53/aws//modules/zones"
#   version = "~> 3.0"

#   zones = {
#     "terraform-aws-modules-example.com" = {
#       comment = "terraform-aws-modules-examples.com (production)"
#       tags = {
#         env = "production"
#       }
#     }

#     "myapp.com" = {
#       comment = "myapp.com"
#     }
#   }

#   tags = {
#     ManagedBy = "Terraform"
#   }
# }

# module "records" {
#   source  = "terraform-aws-modules/route53/aws//modules/records"
#   version = "~> 3.0"

#   zone_name = keys(module.zones.route53_zone_zone_id)[0]

#   records = [
#     {
#       name    = "apigateway1"
#       type    = "A"
#       alias   = {
#         name    = "d-10qxlbvagl.execute-api.eu-west-1.amazonaws.com"
#         zone_id = "ZLY8HYME6SFAD"
#       }
#     },
#     {
#       name    = ""
#       type    = "A"
#       ttl     = 3600
#       records = [
#         "10.10.10.10",
#       ]
#     },
#   ]

#   depends_on = [module.zones]
# }