# Creating Load Balancer
resource "aws_lb" "loadbalancer" {
  name               = "Load-Balancer"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.lb.id]
  subnets            = aws_subnet.public_subnets[*].id
  depends_on = [aws_security_group.lb,
    aws_vpc_security_group_egress_rule.lb_egress,
  aws_vpc_security_group_ingress_rule.lb_ingress]

}

#Creating target group
resource "aws_lb_target_group" "lb_target_group" {
  name     = "LB-Group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main_vpc.id
  health_check {
    enabled             = true
    healthy_threshold   = 4
    interval            = 25
    port                = 80
    unhealthy_threshold = 4
  }
}

# Creating LB listener for HTTP
resource "aws_lb_listener" "HTTP" {
  load_balancer_arn = aws_lb.loadbalancer.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}

# Attaching the instances to the created target group
resource "aws_lb_target_group_attachment" "web_tg" {
  for_each         = { for i, inst in aws_instance.web : i => inst }
  target_id        = each.value.id
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  port             = 80
}

output "dns_name_lb" {
  value = aws_lb.loadbalancer.dns_name
}