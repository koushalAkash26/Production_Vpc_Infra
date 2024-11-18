project_name = "myproject"
vpc_cidr ="10.0.0.0/16"
public_subnet_cidr_a = "10.0.0.0/18"
public_subnet_cidr_b = "10.0.64.0/18"
private_subnet_cidr_a ="10.0.128.0/18"
private_subnet_cidr_b = "10.0.192.0/18"
availability_zone_a = "us-east-1a"
availability_zone_b = "us-east-1b"
ami_id = "ami-0866a3c8686eaeeba"
instance_type ="t2.micro"
key_name = "MyProjectKey"
key_file_path = "./MyProjectKey.pem"
userdata_file_path = "./userdata.sh"
create_bastion_host =true
target_group_name = "my-target-group"
target_group_port = 8000
health_check_path = "/"
health_check_interval = 30
health_check_timeout = 5
healthy_threshold = 2
unhealthy_threshold = 2
alb_name = "my-alb"
alb_internal = false
listener_port = 80
alb_sg_name = "ALB_security_Group"
autoscaling_name = "MyTestAutoScaling"
max_size = 4
min_size = 2
desired_capacity = 2
health_check_type = "EC2"
health_check_grace_period = 300
launch_template_version = "$Latest"
instance_name = "MyInstance"



