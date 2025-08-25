This project demonstrates a hands-on implementation of a multi-tier web application infrastructure on AWS using Terraform. It covers networking, compute, load balancing, and security best practices.

Networking
  1.VPC with public and private subnets
  2.Internet Gateway and NAT Gateway
  3.Custom route tables and associations

Security
  1.Security groups for web servers, load balancer, and database
  2.Proper ingress and egress rules
  3.Restricted database access from web tier

Compute
  1.EC2 instances running a simple web server(NGINX) in public subnets
  2.Application Load Balancer forwarding traffic to EC2 instances
  3.Health checks configured

Database
  1.RDS instance in private subnet with restricted access
  2.Backup enabled

IaC
  1.Fully managed by Terraform
  2.Reusable code