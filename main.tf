module "vpc" {

  source = "git::https://github.com/hemanthtadikonda/vpc_terraform_module.git"

  for_each = var.vpc
  cidr     = each.value["cidr"]
  subnets  = each.value["subnets"]


}

output "vpc" {
  value = module.vpc
}

