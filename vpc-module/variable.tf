variable "project_name" {
  description = "The name prefix for resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr_a" {
  description = "CIDR block for the first public subnet"
  type        = string
}

variable "public_subnet_cidr_b" {
  description = "CIDR block for the second public subnet"
  type        = string
}

variable "private_subnet_cidr_a" {
  description = "CIDR block for the first private subnet"
  type        = string
}

variable "private_subnet_cidr_b" {
  description = "CIDR block for the second private subnet"
  type        = string
}

variable "availability_zone_a" {
  description = "Availability Zone for subnets in set A"
  type        = string
}

variable "availability_zone_b" {
  description = "Availability Zone for subnets in set B"
  type        = string
}
