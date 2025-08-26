# Creating Security Group for Web EC2 Instances
resource "aws_security_group" "web" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "Web-SG"
  }
  name        = "Web-SG"
  description = "This security group is created for EC2 Instances to allow inbound HTTP & HTTPS Traffic"
}
resource "aws_vpc_security_group_ingress_rule" "allow_HTTP_HTTPS" {
  security_group_id = aws_security_group.web.id
  from_port         = var.SG_Ports[length(var.SG_Ports) - 1]
  to_port           = var.SG_Ports[length(var.SG_Ports) - 1]
  ip_protocol       = "tcp"
  cidr_ipv4         = var.all_ipv4
}
resource "aws_vpc_security_group_egress_rule" "allow_HTTP_HTTPS" {
  security_group_id = aws_security_group.web.id
  ip_protocol       = "-1"
  cidr_ipv4         = var.all_ipv4
}

# Creating Security Group for Database
resource "aws_security_group" "db" {
  vpc_id = aws_vpc.main_vpc.id
  name   = "DB-SG"
  tags = {
    Name = "DB-SG"
  }
  description = "This security group is created for Database to allow inbound traffic from Security group Web-SG"
}

# Allowing Ingress only from Web SG to DB's SG
resource "aws_security_group_rule" "web_to_db" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.db.id
  source_security_group_id = aws_security_group.web.id
}

# Security group for EC2 Instances to allow remote-exec
resource "aws_security_group" "SSH_to_web" {
  vpc_id      = aws_vpc.main_vpc.id
  name        = "SSH-SG"
  description = "This security group allows ssh access from specifically my public ip"
  tags = {
    Name = "SSH-SG"
  }
}
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.SSH_to_web.id
  cidr_ipv4         = var.my_public_ip
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}
resource "aws_vpc_security_group_egress_rule" "allow_outbound_all" {
  security_group_id = aws_security_group.SSH_to_web.id
  cidr_ipv4         = var.all_ipv4
  ip_protocol       = "-1"
}

# SG for Load Balancer
resource "aws_security_group" "lb" {
  vpc_id      = aws_vpc.main_vpc.id
  name        = "LB-SG"
  description = "This SG is created for Load Balancer"
}
resource "aws_vpc_security_group_ingress_rule" "lb_ingress" {
  security_group_id = aws_security_group.lb.id
  cidr_ipv4         = var.all_ipv4
  from_port         = var.SG_Ports[length(var.SG_Ports) - 1]
  to_port           = var.SG_Ports[length(var.SG_Ports) - 1]
  ip_protocol       = "tcp"
}
resource "aws_vpc_security_group_egress_rule" "lb_egress" {
  security_group_id = aws_security_group.lb.id
  ip_protocol       = "-1"
  cidr_ipv4         = var.all_ipv4
}