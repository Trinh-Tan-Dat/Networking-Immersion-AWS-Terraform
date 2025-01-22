variable "security_groupC_id" {
  description = "ID of the security group"
  type        = string
}
variable "vpcC_public_subnets" {
  description = "List of IDs of public subnets"
  type        = list(string)
}
variable "vpcC_private_subnets" {
  description = "List of IDs of private subnets"
  type        = list(string)
}
variable "vpcC_id" {
  description = "ID of the VPC"
  type        = string
}