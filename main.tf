module "network" {
  source = "./modules/network"
}

module "security" {
  source            = "./modules/security"
  vpc_id            = module.network.vpc_id
  security_db_sg_id = module.security.security_db_sg_id
}

module "rds" {
  source            = "./modules/rds"
  security_group_id = module.security.db_sg_id
  subnet_ids        = module.network.private_subnet_db_ids

}
module "ec2" {
  source            = "./modules/ec2"
  instance_count    = 2
  subnets           = module.network.private_subnet_web_ids
  security_group_id = module.security.ec2_sg_id
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.network.vpc_id
  subnet_ids        = module.network.public_subnet_ids
  security_group_id = module.security.alb_sg_id
  aws_instance_ids  = module.ec2.aws_web_instance_ids
  instance_count    = 3
}

