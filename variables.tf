# VPC CIDR
variable "vpc_ipv4_cidr" {
  default = "10.0.0.0/16"
}

# Public Subnet CIDR 
variable "public_subnets_ipv4_cidr" {
  type = list(string)
  default = ["10.0.0.0/19","10.0.32.0/19"]
}

# Private Subnet CIDR 
variable "private_subnets_ipv4_cidr" {
  type = list(string)
  default = ["10.0.128.0/18","10.0.192.0/18"]
}

# All IPV4
variable "all_ipv4" {
  default = "0.0.0.0/0"
}

# SG Ports
variable "SG_Ports" {
  type = map(string)
  default = { 
    1 = "443",
    2 = "80" 
  }
}

# Web instance types
variable "instance_type" {
  default = "t2.micro"
}

# Creating variable for the path of private key
variable "private_key_path" {
  default = "./private_key.pem"
}

# Creating AZ ID's
variable "az_id" {
  type = list(string)
  default = ["eu-central-1a","eu-central-1b"]
}