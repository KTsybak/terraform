
# Модуль beanstalk

output "elasticapp_name" {
  value = aws_elastic_beanstalk_application.elasticapp.name
}

output "beanstalkappenv_name" {
  value = aws_elastic_beanstalk_environment.beanstalkappenv.name
}
