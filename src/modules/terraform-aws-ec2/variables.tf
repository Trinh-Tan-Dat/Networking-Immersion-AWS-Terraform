variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "public_subnet_id" {
  description = "Subnet ID for public EC2 instance"
  type        = string
}

variable "private_subnet_id" {
  description = "Subnet ID for private EC2 instance"
  type        = string
}

variable "security_group_id_one" {
  description = "Security group ID to associate with instances"
  type        = string
}
variable "security_group_id_two" {
  description = "Security group ID to associate with instances"
  type        = string
}

variable "key_name" {
  description = "Key pair name for EC2 instances"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}