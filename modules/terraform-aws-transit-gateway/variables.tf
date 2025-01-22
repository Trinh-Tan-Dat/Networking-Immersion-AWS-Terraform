variable "vpcA_id" {
  type = string
}

variable "vpcB_id" {
  type = string
  
}

variable "private_subnets_vpcA" {
  type = list(string)
}

variable "private_subnets_vpcB" {
  type = list(string)
  
}
variable "private_subnets_vpc_on_prem" {
  type = list(string)
}
variable "vpc_on_prem_id" {
  type = string
}