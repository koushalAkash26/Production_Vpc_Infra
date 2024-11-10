resource "aws_vpc" "MyProdVpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "MyProdVpc"
  }
}
# ------Subnet-----------
resource "aws_subnet" "Myproject-Public-us_est_1a" {
  vpc_id     = aws_vpc.MyProdVpc.id
  cidr_block = "10.0.0.0/18"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Myproject-Public-us_est_1a"
  }
}

resource "aws_subnet" "Myproject-Public-us_est_1b" {
  vpc_id     = aws_vpc.MyProdVpc.id
  cidr_block = "10.0.64.0/18"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Myproject-Public-us_est_1b"
  }
}

resource "aws_subnet" "Myproject-Private-us_est_1a" {
  vpc_id     = aws_vpc.MyProdVpc.id
  cidr_block = "10.0.128.0/18"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Myproject-Private-us_est_1a"
  }
}

resource "aws_subnet" "Myproject-Private-us_est_1b" {
  vpc_id     = aws_vpc.MyProdVpc.id
  cidr_block = "10.0.192.0/18"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Myproject-Private-us_est_1b"
  }
}
#--------Internet Gateway---------
resource "aws_internet_gateway" "MyProjectIgw" {
  vpc_id = aws_vpc.MyProdVpc.id

  tags = {
    Name = "MyProjectIgw"
  }
}
#-------Public Route Table----------------
resource "aws_route_table" "MyProjectPublicRT" {
  vpc_id = aws_vpc.MyProdVpc.id

  route {
    cidr_block           = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.MyProjectIgw.id
  }

  tags = {
    Name = "MyProjectPublicRT"
  }
}
#---------Route Table Association for public Route Table--------------
resource "aws_route_table_association" "PublicRTassociation1" {
  subnet_id      = aws_subnet.Myproject-Public-us_est_1a.id
  route_table_id = aws_route_table.MyProjectPublicRT.id
}
resource "aws_route_table_association" "PublicRTassociation2" {
  subnet_id      = aws_subnet.Myproject-Public-us_est_1b.id
  route_table_id = aws_route_table.MyProjectPublicRT.id
}
#---------------NAT GateWay-----------------
resource "aws_eip" "nat_eip_1" {
  domain = "vpc"
}

resource "aws_eip" "nat_eip_2" {
  domain = "vpc"
}


resource "aws_nat_gateway" "nat_gateway_1_us_est_1a" {
  allocation_id = aws_eip.nat_eip_1.id
  subnet_id     = aws_subnet.Myproject-Public-us_est_1a.id

  tags = {
    Name = "nat_gateway_1_us_est_1a"
  }
}

resource "aws_nat_gateway" "nat_gateway_2_us_est_1b" {
  allocation_id = aws_eip.nat_eip_2.id
  subnet_id     = aws_subnet.Myproject-Public-us_est_1b.id

  tags = {
    Name = "nat_gateway_2_us_est_1B"
  }
}
#-------------Private Route Table-----------
resource "aws_route_table" "MyProjectPrivateRT1" {
  vpc_id = aws_vpc.MyProdVpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_1_us_est_1a.id
  }

  tags = {
    Name = "MyProjectPrivateRT1"
  }
}
resource "aws_route_table" "MyProjectPrivateRT2" {
  vpc_id = aws_vpc.MyProdVpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_2_us_est_1b.id
  }

  tags = {
    Name = "MyProjectPrivateRT2"
  }
}
#------------Route Table Association for public Route Table-------
resource "aws_route_table_association" "PrivateRTassociation1" {
  subnet_id      = aws_subnet.Myproject-Private-us_est_1a.id
  route_table_id = aws_route_table.MyProjectPrivateRT1.id
}
resource "aws_route_table_association" "PrivateRTassociation2" {
  subnet_id      = aws_subnet.Myproject-Private-us_est_1b.id
  route_table_id = aws_route_table.MyProjectPrivateRT2.id
}
#---------Security Group for Ec2 instancws-----------------
resource "aws_security_group" "Ec2security_group" {
  name        = "my_security_group"
  description = "Allow custom TCP traffic on port 8000 from anywhere"
  vpc_id      = aws_vpc.MyProdVpc.id # Replace with your VPC ID

  ingress {
    description      = "Allow TCP traffic on port 8000"
    from_port        = 8000
    to_port          = 8000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]  # Allows traffic from any IPv4 address
  }

  ingress {
    description      = "Allow ssh traffic on port 8000"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]  # Allows traffic from any IPv4 address
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"           # Allows all outbound traffic
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Ec2security_group"
  }
}
#----------creating key pair------------
resource "tls_private_key" "ProjectKeyAlgorithm" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "MyProjectKey" {
  key_name   = "MyProjectKey"
  public_key = tls_private_key.ProjectKeyAlgorithm.public_key_openssh
}

resource "local_file" "MyProjectKey" {
    content  = tls_private_key.ProjectKeyAlgorithm.private_key_pem
    filename = "MyProjectKey"
}
#----------Launch Template---------------
resource "aws_launch_template" "MyProject_launch_template" {
  name          = "my-project-launch-template"
  description   = "Launch template for Ubuntu EC2 instance"

  # Instance parameters
  instance_type = "t2.micro"
  image_id      = "ami-0866a3c8686eaeeba"
  key_name = "MyProjectKey"
  # Network configurations
  vpc_security_group_ids = [aws_security_group.Ec2security_group.id]
  

  # Optional: Configure tags for the instance
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "MyEc2Instance"
    }
  }
}


#--------Bastion Host---------------
resource "aws_instance" "my_instance" {
  ami                    = "ami-0866a3c8686eaeeba"  
  instance_type         = "t2.micro"
  subnet_id             = aws_subnet.Myproject-Public-us_est_1a.id
  security_groups       = [aws_security_group.Ec2security_group.id]
  associate_public_ip_address = true
  key_name = "MyProjectKey"  

  tags = {
    Name = "BastionHost"
  }
}
# ------ Create Target Group --------
resource "aws_lb_target_group" "my_target_group" {
  name     = "my-target-group"
  port     = 8000
  protocol = "HTTP"
  vpc_id   = aws_vpc.MyProdVpc.id

  health_check {
    path                = "/"  # Specify the health check path
    interval            = 30
    timeout             = 5
    healthy_threshold  = 2
    unhealthy_threshold = 2
  }


  tags = {
    Name = "MyTargetGroup"
  }
}
#-------SG for ALB--------------
resource "aws_security_group" "ALB_SG" {
  name        = "ALB_security_Group"
  description = "Allow custom TCP traffic on port 80 from anywhere"
  vpc_id      = aws_vpc.MyProdVpc.id # Replace with your VPC ID

  ingress {
    description      = "Allow TCP traffic on port 80"
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]  # Allows traffic from any IPv4 address
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"           # Allows all outbound traffic
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ALB_SG"
  }
}

# ------ Create Application Load Balancer --------
resource "aws_lb" "my_alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ALB_SG.id]
  subnets            = [aws_subnet.Myproject-Public-us_est_1a.id,aws_subnet.Myproject-Public-us_est_1b.id]

  

  tags = {
    Name = "MyApplicationLoadBalancer"
  }
}
#-----Listener Rules---------
resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }
}

#-----------AutoScaling--------------------
resource "aws_autoscaling_group" "MyTestAutoScaling" {
  name                      = "MyTestAutoScaling"
  max_size                  = 4
  min_size                  = 2
  health_check_type  = "EC2"
  health_check_grace_period = 300
  launch_template {
    id      = aws_launch_template.MyProject_launch_template.id
    version = "$Latest"
  }
  vpc_zone_identifier       = [aws_subnet.Myproject-Private-us_est_1a.id, aws_subnet.Myproject-Private-us_est_1b.id]
  target_group_arns = [aws_lb_target_group.my_target_group.arn]

}