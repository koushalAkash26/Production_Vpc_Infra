output "launch_template_id" {
  description = "ID of the Launch Template"
  value       = aws_launch_template.launch_template.id
}

output "key_pair_name" {
  description = "Name of the key pair"
  value       = aws_key_pair.key_pair.key_name
}

output "bastion_host_public_ip" {
  description = "Public IP of the bastion host"
  value       = var.create_bastion_host ? aws_instance.bastion_host[0].public_ip : null
}