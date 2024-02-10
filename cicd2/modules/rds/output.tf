output "database_endpoint" {
  value = aws_db_instance.myinstance.endpoint
}

output "database_username" {
  value = aws_db_instance.myinstance.username
}

output "database_password" {
  value = aws_db_instance.myinstance.password
}