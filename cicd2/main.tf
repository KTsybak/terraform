
  module "vpc" {
  source = "./modules/vpc/"
}
module "rds" {
  source = "./modules/rds" 
  vpc_id = module.vpc.vpc_id
  rds_subnet_1_id = module.vpc.private_subnets_id[0]
  rds_subnet_2_id = module.vpc.private_subnets_id[1]
  user = module.vault.user
  pass = module.vault.pass
}
  
  module "beanstalk" {
  source = "./modules/beanstalk/"
  solution_stack_name               = var.solution_stack_name
  tier                          = var.tier
  addres = module.rds.database_endpoint
  user = module.rds.database_username
  pass = module.rds.database_password
  vpc_id = module.vpc.vpc_id
  ec2_subnets = module.vpc.public_subnets_id[0]
  mount = module.efs.mount
}

  
  module "efs" {
  source = "./modules/efs/"
  vpc_id = module.vpc.vpc_id
  subnet1 = module.vpc.public_subnets_id[0]
  
}
  module "s3" {
  source = "./modules/s3/"
}
  module "codebuild" {
  source = "./modules/codebuild"
  

}
  module "codepipeline" {
  source = "./modules/codepipeline/"
  buck_name1 = module.s3.name_bucket
  elasticapp_name = module.beanstalk.elasticapp_name
  beanstalkappenv_name = module.beanstalk.beanstalkappenv_name
  codebuild_project_name = module.codebuild.codebuild_project_name
 

}
  module "vault" {
  source = "./modules/vault"
  

}