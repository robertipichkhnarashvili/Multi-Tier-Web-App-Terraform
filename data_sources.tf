data "aws_ami" "EC2_Latest_AMI" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["aws-elasticbeanstalk-amzn-2.0.20241113.64bit-eb_go1_amazon_linux_2-hvm-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}