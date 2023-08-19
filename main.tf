module "subnets" {
  source = "git::https://github.com/hemanthtadikonda/vpc_terraform_module.git"
  for_each = var.subnets
  vpc = var.vpc
  subnets = var.subnets

}

