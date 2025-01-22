variable "public_subnet" {
  description = "List of IDs of public subnets"
  type        = string
}
variable "security_group_id" {
  description = "ID of the security group"
  type        = string
}
variable "private_subnet" {
  description = "List of IDs of private subnets"
  type        = string
}