output "alb_dns_name" {
  value = module.alb.alb_dns_name
  description = "The DNS name of the Application Load Balancer"
}
output "Bastion_host"{
    value = module.ec2launchtemplate.bastion_host_public_ip
    description = "The Public IP for the bastion host"
}
output "PrivateIps_of_the_Server" {
    value = [for instanceip in data.aws_instances.asg_instances.private_ips:instanceip]
    description = "The Private Ip'S of the Application Running server"
}



