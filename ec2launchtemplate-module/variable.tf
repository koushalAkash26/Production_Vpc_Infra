variable "project_name" {
  description = "The name prefix for resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where resources will be created"
  type        = string
}

variable "public_subnet_id" {
  description = "Subnet ID for the bastion host (optional)"
  type        = string
}

variable "ami_id" {
  description = "AMI ID to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the key pair"
  type        = string
  default     = "MyProjectKey"
}


variable "key_file_path" {
  description = "Path to save the private key locally"
  type        = string
  default     = "./MyProjectKey.pem"
}

variable "userdata_file_path" {
  description = "path to userdata file"
  type = string
  
}

variable "create_bastion_host" {
  description = "Flag to create a bastion host"
  type        = bool
  default     = false
}


