variable "project_name" {
    type = string
    description = "The Project_Name"
    #default = "myproject"
  
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  #default = "10.0.0.0/16"
}

variable "public_subnet_cidr_a" {
  description = "CIDR block for the first public subnet"
  type        = string
  #default = "10.0.0.0/18"
}

variable "public_subnet_cidr_b" {
  description = "CIDR block for the second public subnet"
  type        = string
  #default = "10.0.64.0/18"
}

variable "private_subnet_cidr_a" {
  description = "CIDR block for the first private subnet"
  type        = string
  #default = "10.0.128.0/18"
}

variable "private_subnet_cidr_b" {
  description = "CIDR block for the second private subnet"
  type        = string
  #default = "10.0.192.0/18"
}

variable "availability_zone_a" {
  description = "Availability Zone for subnets in set A"
  type        = string
  #default = "us-east-1a"
}

variable "availability_zone_b" {
  description = "Availability Zone for subnets in set B"
  type        = string
  #default = "us-east-1b"
}

variable "ami_id" {
  description = "AMI ID to use for the instance"
  type        = string
  #default = "ami-0866a3c8686eaeeba"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  #default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the key pair"
  type        = string
  #default     = "MyProjectKey"
}


variable "key_file_path" {
  description = "Path to save the private key locally"
  type        = string
  #default     = "./MyProjectKey.pem"
}

variable "userdata_file_path" {
  description = "path to userdata file"
  type = string
  #default = "./userdata.sh"
  
}

variable "create_bastion_host" {
  description = "Flag to create a bastion host"
  type        = bool
  #default     = true
}
variable "target_group_name" {
  description = "The name of the target group"
  type        = string
  #default = "my-target-group"
}

variable "target_group_port" {
  description = "The port for the target group"
  type        = number
  #default     = 8000
}

variable "health_check_path" {
  description = "The health check path for the target group"
  type        = string
  #default     = "/"
}

variable "health_check_interval" {
  description = "The interval for the health check"
  type        = number
  #default     = 30
}

variable "health_check_timeout" {
  description = "The timeout for the health check"
  type        = number
  #default     = 5
}

variable "healthy_threshold" {
  description = "The healthy threshold for the health check"
  type        = number
  #default     = 2
}

variable "unhealthy_threshold" {
  description = "The unhealthy threshold for the health check"
  type        = number
  #default     = 2
}

variable "alb_name" {
  description = "The name of the Application Load Balancer"
  type        = string
  #default = "my-alb"
}

variable "alb_internal" {
  description = "Whether the ALB is internal or internet-facing"
  type        = bool
  #default     = false
}
variable "listener_port" {
  description = "The port for the ALB listener"
  type        = number
  #default     = 80
}
variable "alb_sg_name" {
  description = "The name of the ALB security group"
  type        = string
  #default = "ALB_security_Group"
}

# modules/autoscaling/variables.tf

variable "autoscaling_name" {
  description = "The name of the Auto Scaling group"
  type        = string
  #default = "MyTestAutoScaling"
}

variable "max_size" {
  description = "The maximum number of instances in the Auto Scaling group"
  type        = number
  #default = 4
}

variable "min_size" {
  description = "The minimum number of instances in the Auto Scaling group"
  type        = number
  #default = 2
}

variable "desired_capacity" {
  description = "The desired capacity of instances in the Auto Scaling group"
  type        = number
  #default     = 2
}

variable "health_check_type" {
  description = "The health check type for the Auto Scaling group"
  type        = string
  #default     = "EC2"
}

variable "health_check_grace_period" {
  description = "The grace period for health checks"
  type        = number
  #default     = 300
}


variable "launch_template_version" {
  description = "The version of the launch template to use"
  type        = string
  #default     = "$Latest"
}

variable "instance_name" {
  description = "Name tag for instances launched by the Auto Scaling group"
  type        = string
  #default = "MyInstance"
}
