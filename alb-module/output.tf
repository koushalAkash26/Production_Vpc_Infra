output "alb_security_group_id" {
  description = "The security group ID for the ALB"
  value       = aws_security_group.alb_sg.id
}

output "target_group_arn" {
  description = "The ARN of the target group"
  value       = aws_lb_target_group.target_group.arn
}
output "alb_dns_name" {
  value = aws_lb.alb.dns_name
  description = "The DNS name of the Application Load Balancer"
}

output "alb_arn" {
  description = "The ARN of the ALB"
  value       = aws_lb.alb.arn
}

output "listener_arn" {
  description = "The ARN of the ALB listener"
  value       = aws_lb_listener.listener.arn
}
