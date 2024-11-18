# modules/autoscaling/variables.tf

variable "name" {
  description = "The name of the Auto Scaling group"
  type        = string
}

variable "max_size" {
  description = "The maximum number of instances in the Auto Scaling group"
  type        = number
}

variable "min_size" {
  description = "The minimum number of instances in the Auto Scaling group"
  type        = number
}

variable "desired_capacity" {
  description = "The desired capacity of instances in the Auto Scaling group"
  type        = number
  default     = 2
}

variable "health_check_type" {
  description = "The health check type for the Auto Scaling group"
  type        = string
  default     = "EC2"
}

variable "health_check_grace_period" {
  description = "The grace period for health checks"
  type        = number
  default     = 300
}

variable "launch_template_id" {
  description = "The ID of the launch template to use"
  type        = string
}

variable "launch_template_version" {
  description = "The version of the launch template to use"
  type        = string
  default     = "$Latest"
}

variable "vpc_zone_identifier" {
  description = "The list of subnet IDs for the Auto Scaling group"
  type        = list(string)
}

variable "target_group_arns" {
  description = "The list of target group ARNs to associate with the Auto Scaling group"
  type        = list(string)
}

variable "instance_name" {
  description = "Name tag for instances launched by the Auto Scaling group"
  type        = string
}
