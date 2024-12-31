variable "security_groupB_id" {
  description = "ID of the security group"
  type        = string
}
variable "vpcB_public_subnets" {
  description = "List of IDs of public subnets"
  type        = list(string)
}
variable "vpcB_private_subnets" {
  description = "List of IDs of private subnets"
  type        = list(string)
}