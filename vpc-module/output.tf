output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.MainVpc.id
}

output "public_subnets" {
  description = "The IDs of the public subnets"
  value       = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id]
}

output "private_subnets" {
  description = "The IDs of the private subnets"
  value       = [aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id]
}

output "nat_gateways" {
  description = "The IDs of the NAT Gateways"
  value       = [aws_nat_gateway.nat_gateway_a.id, aws_nat_gateway.nat_gateway_b.id]
}
