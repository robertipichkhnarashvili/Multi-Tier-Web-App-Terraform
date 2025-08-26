resource "aws_db_instance" "rds_db_1" {
  allocated_storage = 24
  db_name = "database1"
  engine = "mysql"
  engine_version = var.db_engine_version
  instance_class = "db.m5.large"
  username = "robaflex1"
  password = var.password
  vpc_security_group_ids = [aws_security_group.db.id]
  parameter_group_name = aws_db_parameter_group.p_group.name
  skip_final_snapshot = false 
  availability_zone = var.az_id[0]
  db_subnet_group_name = aws_db_subnet_group.subnet_group.name
  identifier = "db-1"
  backup_retention_period = 24
  backup_window = "03:00-04:00"
  final_snapshot_identifier = "my-final-snapshot-1"
}
resource "aws_db_instance" "rds_db_2" {
  allocated_storage = 24
  db_name = "database2"
  engine = "mysql"
  engine_version = var.db_engine_version
  instance_class = "db.m5.large"
  username = "robaflex2"
  password = var.password
  vpc_security_group_ids = [aws_security_group.db.id]
  parameter_group_name = aws_db_parameter_group.p_group.name
  skip_final_snapshot = false 
  availability_zone = var.az_id[1]
  db_subnet_group_name = aws_db_subnet_group.subnet_group.name
  identifier = "db-2"
  backup_retention_period = 24
  backup_window = "03:00-04:00"
  final_snapshot_identifier = "my-final-snapshot-2"
}
resource "aws_db_subnet_group" "subnet_group" {
  name = "db_subnet_groups_1"
  subnet_ids = ["${aws_subnet.private_subnets[0].id}","${aws_subnet.private_subnets[1].id}"]
}
resource "aws_db_parameter_group" "p_group" {
  name = "rds-pg"
  family = "mysql8.0"
  parameter {
    name = "max_connections"
    value = 40
  }
}