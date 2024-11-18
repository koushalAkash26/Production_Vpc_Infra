module "vpc" {
  source               = "./vpc-module"  # Adjust the path to where the module is located
  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidr_a = var.public_subnet_cidr_a
  public_subnet_cidr_b = var.public_subnet_cidr_b
  private_subnet_cidr_a = var.private_subnet_cidr_a
  private_subnet_cidr_b = var.private_subnet_cidr_b
  availability_zone_a  = var.availability_zone_a
  availability_zone_b  = var.availability_zone_b
}

module "ec2launchtemplate" {
  source             = "./ec2launchtemplate-module"
  project_name       = var.project_name
  vpc_id             = module.vpc.vpc_id
  public_subnet_id   = module.vpc.public_subnets[0]
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  key_name           = var.key_name
  key_file_path      = var.key_file_path
  userdata_file_path = var.userdata_file_path
  create_bastion_host = var.create_bastion_host

}

module "alb" {
  source                = "./alb-module"
  alb_sg_name           = var.alb_sg_name
  vpc_id                = module.vpc.vpc_id
  target_group_name     = var.target_group_name
  target_group_port     = var.target_group_port
  health_check_path     = var.health_check_path
  health_check_interval = var.health_check_interval
  health_check_timeout  = var.health_check_timeout
  healthy_threshold     = var.healthy_threshold
  unhealthy_threshold   = var.unhealthy_threshold
  alb_name              = var.alb_name
  alb_internal          = var.alb_internal
  subnet_ids            = module.vpc.public_subnets
  listener_port         = var.listener_port
}
module "autoscaling" {
  source                   = "./autoscaling-module"
  name                     = var.autoscaling_name
  max_size                 = var.max_size
  min_size                 = var.min_size
  desired_capacity         = var.desired_capacity
  health_check_type        = var.health_check_type
  health_check_grace_period = var.health_check_grace_period
  launch_template_id       = module.ec2launchtemplate.launch_template_id
  launch_template_version  = var.launch_template_version
  target_group_arns        = [module.alb.target_group_arn]
  vpc_zone_identifier      = module.vpc.private_subnets
  instance_name            = var.instance_name
}

data "aws_instances" "asg_instances" {
  filter {
    name   = "tag:Name"
    values = [var.instance_name]
    
  }
  depends_on = [ module.autoscaling ]
}