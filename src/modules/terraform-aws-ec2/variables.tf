variable "public_subnets_vpcA" {
    description = "The ID of the subnet in which to create the security group."
    type = string
}

variable "public_subnets_vpcB" {
    description = "The ID of the subnet in which to create the security group."
    type = string   
  
}

variable "security_group_ids_vpcA" {
    description = "The IDs of the security groups to associate with the network interface in your VPC."
    type = list(string)
}


variable "security_group_ids_vpcB" {
    description = "The IDs of the security groups to associate with the network interface in your VPC."
    type = list(string)
}

variable "private_subnets_vpcA" {
    description = "The ID of the subnet in which to create the security group."
    type = string
}

variable "private_subnets_vpcB" {
    description = "The ID of the subnet in which to create the security group."
    type = string   
  
}