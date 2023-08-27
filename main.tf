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














