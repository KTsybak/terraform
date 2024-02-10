# Create elastic beanstalk application
 
resource "aws_elastic_beanstalk_application" "elasticapp" {
  name = var.elasticapp
}
 
# Create elastic beanstalk Environment
 
resource "aws_elastic_beanstalk_environment" "beanstalkappenv" {
  name                = var.beanstalkappenv
  application         = aws_elastic_beanstalk_application.elasticapp.name
  solution_stack_name = var.solution_stack_name
  tier                = var.tier
   

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
  }
    setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = var.ec2_subnets
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "true" 
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = "aws-elasticbeanstalk-ec2-role"
  }

   setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     =  "aws-ec2-instance"
  }
  setting {
    name = "EnvironmentType"
    namespace = "aws:elasticbeanstalk:environment"
    resource = ""
    value = "SingleInstance"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t3.micro"
  }
 
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }
   setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "IP_VALUE"
    value     = var.addres
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_USER"
    value     = var.user
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_PASSWORD"
    value     = var.pass
  }
    setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "FILE_SYSTEM_ID"
    value     = var.mount
  }

}