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
  sg_port  = var.sg_port
  tags     = var.tags
  env      = var.env


}






