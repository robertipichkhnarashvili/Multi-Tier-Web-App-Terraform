# VPC Creatinon
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_ipv4_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "Main VPC, consisting of 2 public and 2 private subnets"
  }
}

# Creation of 2 Public Subnets
resource "aws_subnet" "public_subnets" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.public_subnets_ipv4_cidr[count.index] 
  count = 2
  map_public_ip_on_launch = true
  depends_on = [ aws_vpc.main_vpc ]
  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
  availability_zone = var.az_id[count.index]
}

# Creation of 2 Private Subnets
resource "aws_subnet" "private_subnets" {
  vpc_id = aws_vpc.main_vpc.id
  count = 2
  cidr_block = var.private_subnets_ipv4_cidr[count.index]
  map_public_ip_on_launch = false 
  depends_on = [ aws_vpc.main_vpc ]
  availability_zone = var.az_id[count.index]
  tags = {
    Name = "Private Subnet ${count.index + 1}"
  }
  
}

# Creation of Internet gateway and IGW attachment to the VPC
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.main_vpc.id
  depends_on = [ aws_vpc.main_vpc ]
  tags = {
    Name = "main"
  }
}

# EIP creation for NAT Gateway Creation
resource "aws_eip" "NAT_EIP" {
  domain = "vpc"
}
resource "aws_nat_gateway" "NAT_in_Public_Subnets" {
  allocation_id = aws_eip.NAT_EIP.id
  subnet_id = aws_subnet.public_subnets[0].id
}