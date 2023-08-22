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



output "vpc" {
  value = module.vpc
}

