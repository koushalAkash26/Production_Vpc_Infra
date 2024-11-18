# -------- Security Group for EC2 Instances --------
resource "aws_security_group" "ec2_security_group" {
  name        = "${var.project_name}-security-group"
  description = "Allow SSH and custom TCP traffic on port 8000"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow TCP traffic on port 8000"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-security-group"
  }
}

# -------- Key Pair --------
resource "tls_private_key" "project_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.project_key.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.project_key.private_key_pem
  filename = var.key_file_path
}

# -------- Launch Template --------
resource "aws_launch_template" "launch_template" {
  name_prefix   = "${var.project_name}-lt-"
  description   = "Launch template for ${var.project_name} instances"
  instance_type = var.instance_type
  image_id      = var.ami_id
  key_name      = aws_key_pair.key_pair.key_name
  user_data = base64encode(file(var.userdata_file_path))

  # Network configurations
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]

  # Tag specification for instance
  tags = {
    Name = "MyEC2instance"
  }
  
}

# -------- Bastion Host (Optional) --------
resource "aws_instance" "bastion_host" {
  count                    = var.create_bastion_host ? 1 : 0
  ami                      = var.ami_id
  instance_type            = var.instance_type
  subnet_id                = var.public_subnet_id
  vpc_security_group_ids   = [aws_security_group.ec2_security_group.id]
  associate_public_ip_address = true
  key_name                 = aws_key_pair.key_pair.key_name

  tags = {
    Name = "${var.project_name}-bastion-host"
  }
}
