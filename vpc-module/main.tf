# -------- VPC --------
resource "aws_vpc" "MainVpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# -------- Subnets --------
resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.MainVpc.id
  cidr_block        = var.public_subnet_cidr_a
  availability_zone = var.availability_zone_a
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet-a"
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id            = aws_vpc.MainVpc.id
  cidr_block        = var.public_subnet_cidr_b
  availability_zone = var.availability_zone_b
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet-b"
  }
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.MainVpc.id
  cidr_block        = var.private_subnet_cidr_a
  availability_zone = var.availability_zone_a

  tags = {
    Name = "${var.project_name}-private-subnet-a"
  }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.MainVpc.id
  cidr_block        = var.private_subnet_cidr_b
  availability_zone = var.availability_zone_b

  tags = {
    Name = "${var.project_name}-private-subnet-b"
  }
}

# -------- Internet Gateway --------
resource "aws_internet_gateway" "MainVpc" {
  vpc_id = aws_vpc.MainVpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# -------- Public Route Table --------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.MainVpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.MainVpc.id
  }

  tags = {
    Name = "${var.project_name}-public-route-table"
  }
}

# -------- Public Route Table Associations --------
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public.id
}

# -------- Elastic IPs for NAT Gateways --------
resource "aws_eip" "nat_a" {
  domain = "vpc"
}

resource "aws_eip" "nat_b" {
  domain = "vpc"
}

# -------- NAT Gateways --------
resource "aws_nat_gateway" "nat_gateway_a" {
  allocation_id = aws_eip.nat_a.id
  subnet_id     = aws_subnet.public_subnet_a.id

  tags = {
    Name = "${var.project_name}-nat-gateway-a"
  }
}

resource "aws_nat_gateway" "nat_gateway_b" {
  allocation_id = aws_eip.nat_b.id
  subnet_id     = aws_subnet.public_subnet_b.id

  tags = {
    Name = "${var.project_name}-nat-gateway-b"
  }
}

# -------- Private Route Tables --------
resource "aws_route_table" "private_a" {
  vpc_id = aws_vpc.MainVpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_a.id
  }

  tags = {
    Name = "${var.project_name}-private-route-table-a"
  }
}

resource "aws_route_table" "private_b" {
  vpc_id = aws_vpc.MainVpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_b.id
  }

  tags = {
    Name = "${var.project_name}-private-route-table-b"
  }
}

# -------- Private Route Table Associations --------
resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.private_a.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.private_b.id
}
