module "vpc" {

  source = "git::https://github.com/hemanthtadikonda/tf-module-vpc.git"

  for_each       = var.vpc
  cidr           = each.value["cidr"]
  subnets        = each.value["subnets"]
  default_vpc_id = var.default_vpc_id
  default_cidr   = var.default_cidr
  default_route_table_id = var.default_route_table_id
  tags     = var.tags
  env      = var.env

}
module "alb" {

  source = "git::https://github.com/hemanthtadikonda/tf-module-alb.git"

  for_each = var.alb
  lb_type  = each.value ["lb_type"]
  internal = each.value["internal"]
  vpc_id   = each.value["internal"] ? local.vpc_id : var.default_vpc_id
  sg_cidr_blocks = each.value["sg_cidr_blocks"]
  subnets = each.value["internal"] ? local.app_subnets : data.aws_subnets.subnets.ids
  sg_port  = each.value["sg_port"]
  tags     = var.tags
  env      = var.env
}

module "docdb" {
  source = "git::https://github.com/hemanthtadikonda/tf-module-docdb.git"

  for_each = var.docdb
  subnets  = local.db_subnets
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  skip_final_snapshot     = each.value["skip_final_snapshot"]
  vpc_id                  = local.vpc_id
  cidr_blocks             = local.app_subnets_cidr_block
  instance_class          = each.value["instance_class"]
  instance_count          = each.value["instance_count"]
  engine_version          = each.value["engine_version"]
  family                  = each.value["family"]
  env                     = var.env
  tags                    = var.tags
}

module "rds" {
  source = "git::https://github.com/hemanthtadikonda/tf-module-rds.git"

  for_each = var.rds

  env = var.env
  tags = var.tags

  subnet_ids               = local.db_subnets
  sg_ingress_cidr          = local.app_subnets_cidr_block
  vpc_id                   = local.vpc_id

  rds_type                 = each.value["rds_type"]
  ingres_port              = each.value["ingres_port"]
  family                   = each.value["family"]
  engine_version           = each.value["engine_version"]
  backup_retention_period  = each.value["backup_retention_period"]
  preferred_backup_window  = each.value["preferred_backup_window"]
  skip_final_snapshot      = each.value["skip_final_snapshot"]
  instance_count           = each.value["instance_count"]
  instance_class           = each.value["instance_class"]
  engine                   = each.value["engine"]
}

module "elasticache" {
  source = "git::https://github.com/hemanthtadikonda/tf-module-elasticache.git"
  env                     = var.env
  tags                    = var.tags

  for_each = var.elasticache

  subnet_ids              = local.db_subnets
  vpc_id                  = local.vpc_id
  sg_ingress_cidr_blocks  = local.app_subnets_cidr_block

  pg_family       = each.value["pg_family"]
  engine          = each.value["engine"]
  dbport          = each.value["dbport"]
  node_type       = each.value["node_type"]
  num_cache_nodes = each.value["num_cache_nodes"]
  engine_version  = each.value["engine_version"]
}

module "rabbitmq" {
  source = "giit::https://github.com/hemanthtadikonda/tf-module-rabbitmq.git"

  for_each         = var.rabbitmq

  env              = var.env
  tags             = var.tags
  zone_id          = var.zone_id
  ssh_ingress_cidr = var.ssh_ingress_cidr

  sg_ingress_cidr  = local.app_subnets_cidr_block
  subnet_ids       = local.db_subnets
  vpc_id           = local.vpc_id

  instance_type    = each.value["instance_type"]
}


module "apps" {
  source = "git::https://github.com/hemanthtadikonda/tf-module-apps.git"

  for_each = var.apps

  env              = var.env
  tags             = var.tags
  ssh_ingress_cidr = var.ssh_ingress_cidr
  zone_id          = var.zone_id

  vpc_id            = local.vpc_id
  sg_ingress_cidr   = local.app_subnets_cidr_block
  private_alb_dns   = local.private_alb_dns
  app_subnet_ids    = local.app_subnets


  component         = each.key
  app_port          = each.value["app_port"]
  instance_type     = each.value["instance_type"]
  desired_capacity  = each.value["desired_capacity"]
  max_size          = each.value["max_size"]
  min_size          = each.value["min_size"]
}















