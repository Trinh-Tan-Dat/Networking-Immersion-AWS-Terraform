output "nlb_dns_name" {
  value = module.nlb.dns_name
  description = "The DNS name of the Network Load Balancer"
}