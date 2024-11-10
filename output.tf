output "BastionHostIp" {
  value = aws_instance.my_instance.public_ip
  description = "The Bation Host's Public IP"
}
