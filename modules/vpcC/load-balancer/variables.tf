variable "vpcC_id" {
  description = "ID of the VPC"
  type        = string
}
variable "vpcC_public_subnets" {
  description = "List of IDs of public subnets"
  type        = list(string)
}
variable "security_groupC_id" {
  description = "ID of the security group"
  type        = string
}
variable "instance_ids" {
  description = "List of IDs of public subnets"
  type        = list(string)
}