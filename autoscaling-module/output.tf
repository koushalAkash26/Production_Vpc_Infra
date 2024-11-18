output "autoscaling_group_id" {
  description = "The ID of the Auto Scaling group"
  value       = aws_autoscaling_group.autoscaling_group.id
}
