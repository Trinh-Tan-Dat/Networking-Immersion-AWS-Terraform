variable "vpcB_id" {
  description = "ID of the VPC"
  type        = string
}
variable "vpcB_public_subnets" {
  description = "List of IDs of public subnets"
  type        = list(string)
}
variable "security_groupB_id" {
  description = "ID of the security group"
  type        = string
}
variable "instance_ids" {
  description = "List of IDs of public subnets"
  type        = list(string)
}