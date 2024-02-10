resource "aws_security_group" "rds_sg" {
  name = "rds_sg"
  vpc_id   = var.vpc_id
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_db_subnet_group" "_" {
  name       = "my-subnet-group"
  subnet_ids = [var.rds_subnet_1_id, var.rds_subnet_2_id]
}
resource "aws_db_instance" "myinstance" {
  engine               = "mariadb"
  identifier           = "myrds"
  db_name              = "gitbucket"
  allocated_storage    =  20
  storage_type         = "gp2"
  port                 = "3306"
  engine_version       = "10.6.14"
  instance_class       = "db.t3.micro"
  username             = var.user
  password             = var.pass
  parameter_group_name = "default.mariadb10.6"
  multi_az = false
  backup_retention_period = 0
  vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]
  db_subnet_group_name    = aws_db_subnet_group._.id
  skip_final_snapshot  = true
  publicly_accessible =  true
  final_snapshot_identifier = false
   tags = {
    Name = "example-db"
  }
}