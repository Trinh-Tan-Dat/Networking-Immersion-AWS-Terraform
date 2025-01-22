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