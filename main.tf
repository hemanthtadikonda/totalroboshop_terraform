module "vpc" {

  source = "git::https://github.com/hemanthtadikonda/vpc_terraform_module.git"

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





