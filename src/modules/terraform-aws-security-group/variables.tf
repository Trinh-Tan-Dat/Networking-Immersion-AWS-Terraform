
variable "vpc_id" {
  description = "Id of vpc"
  type = string
}

variable "public_subnet_ids" {
    description = "List of public subnets"
    type = list(string)
}

variable "private_subnet_ids" {
    description = "List of private subnets"
    type = list(string)
}

variable "tags" {
    description = "Tags for the VPC and its resources"
    type = map(string)
    default = {}
  
}