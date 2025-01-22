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