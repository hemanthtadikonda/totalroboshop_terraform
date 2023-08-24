locals {
  # created vpc id
  vpc_id =  lookup(lookup(module.vpc, "main", null), "aws_vpc_id", null)
  app_subnets = [for k, v in lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), "app", null), "subnet_ids", null) : v.id]
  db_subnets = [for k, v in lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), "db", null), "subnet_ids", null) : v.id]

  app_subnets_cidr_block = [for k, v in lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), "app", null), "subnet_ids", null) : v.cidr_block]
}