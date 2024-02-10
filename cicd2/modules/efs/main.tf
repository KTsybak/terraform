# Creating Amazon EFS File system
resource "aws_efs_file_system" "myfilesystem" {
  encrypted = "true"
  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
# Tagging the EFS File system with its value as Myfilesystem
  tags = {
    Name = "Myfilesystem"
  }
}


resource "aws_efs_mount_target" "example-efs-mt" {

   file_system_id = aws_efs_file_system.myfilesystem.id

   subnet_id = var.subnet1

   security_groups = ["${aws_security_group.efs_security_group.id}"]

}
resource "aws_security_group" "efs_security_group" {
name        = "ec2_security_group"
description = "Allow SSH and HTTP"
vpc_id      = var.vpc_id
ingress {
description = "SSH from VPC"
from_port   = 22
to_port     = 22
protocol    = "tcp"
cidr_blocks = ["0.0.0.0/0"]
  }
ingress {
description = "EFS mount target"
from_port   = 2049
to_port     = 2049
protocol    = "tcp"
cidr_blocks = ["0.0.0.0/0"]
  }
ingress {
description = "HTTP from VPC"
from_port   = 80
to_port     = 80
protocol    = "tcp"
cidr_blocks = ["0.0.0.0/0"]
  }
egress {
from_port   = 0
to_port     = 0
protocol    = "-1"
cidr_blocks = ["0.0.0.0/0"]
  }
}