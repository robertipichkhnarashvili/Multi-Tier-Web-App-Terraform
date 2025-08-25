resource "aws_instance" "web" {
  ami = data.aws_ami.EC2_Latest_AMI.id
  instance_type = var.instance_type
  count = 2
  vpc_security_group_ids = [aws_security_group.web.id, aws_security_group.SSH_to_web.id]
  key_name = "private_key"
  provisioner "remote-exec" {
    inline = ["sudo yum update -y", 
               "sudo yum upgrade -y",
               "sudo yum install nginx -y",
               "sudo systemctl enable nginx ",
               "sudo systemctl start nginx "]  
  }
  connection {
    type = "ssh"
    host = self.public_ip
    user = "ec2-user"
    private_key = file(var.private_key_path)
  }
  tags = {
    Name = "Web_EC2-${count.index + 1}"
  }
  subnet_id = aws_subnet.public_subnets[count.index].id
}