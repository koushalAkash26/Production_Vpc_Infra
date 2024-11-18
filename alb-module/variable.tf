# modules/alb/variables.tf

variable "alb_sg_name" {
  description = "The name of the ALB security group"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the resources will be created"
  type        = string
}

variable "target_group_name" {
  description = "The name of the target group"
  type        = string
}

variable "target_group_port" {
  description = "The port for the target group"
  type        = number
  default     = 80
}

variable "health_check_path" {
  description = "The health check path for the target group"
  type        = string
  default     = "/"
}

variable "health_check_interval" {
  description = "The interval for the health check"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "The timeout for the health check"
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "The healthy threshold for the health check"
  type        = number
  default     = 2
}

variable "unhealthy_threshold" {
  description = "The unhealthy threshold for the health check"
  type        = number
  default     = 2
}

variable "alb_name" {
  description = "The name of the Application Load Balancer"
  type        = string
}

variable "alb_internal" {
  description = "Whether the ALB is internal or internet-facing"
  type        = bool
  default     = false
}

variable "subnet_ids" {
  description = "The subnets for the ALB"
  type        = list(string)
}

variable "listener_port" {
  description = "The port for the ALB listener"
  type        = number
  default     = 80
}
