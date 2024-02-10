  module "vpc" {
  source = "./modules/vpc/"
}
  module "ec2"{
  source = "./modules/ec2"
  subnet_prv1 = module.vpc.public_subnets_id[0]
  myvpc = module.vpc.vpc_id
}