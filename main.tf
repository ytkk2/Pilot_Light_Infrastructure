module "network" {
  source = "./modules/network"
}

module "security" {
  source            = "./modules/security"
  vpc_id            = module.network.vpc_id
  security_db_sg_id = module.security.security_db_sg_id
}

module "route53" {
  source       = "./modules/route53"
  domain_name  = var.domain_name
  alb_dns_name = module.alb.dns_name
  alb_zone_id  = module.alb.zone_id
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.network.vpc_id
  subnet_ids        = module.network.public_subnet_ids
  security_group_id = module.security.alb_sg_id
  aws_instance_ids  = module.ec2.aws_web_instance_ids
  instance_count    = var.instance_count
}

module "rds" {
  source            = "./modules/rds"
  security_group_id = module.security.db_sg_id
  subnet_ids        = module.network.private_subnet_db_ids

}
module "ec2" {
  source            = "./modules/ec2"
  instance_count    = var.instance_count
  subnets           = module.network.private_subnet_web_ids
  security_group_id = module.security.ec2_sg_id
}

module "cloudtrail" {
  source          = "./modules/cloudtrail"
  bucket_name     = var.bucket_name
  cloudtrail_name = var.cloudtrail_name
}

module "waf" {
  source     = "./modules/waf"
  alb_arn    = module.alb.alb_arn
  rate_limit = var.rate_limit
}