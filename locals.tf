locals {
  # created vpc id
  vpc_id =  lookup(lookup(module.vpc, "main", null), "aws_vpc_id", null)
  app_subnets = [for k, v in lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), "app", null), "subnet_ids", null) : v.id]
  db_subnets = [for k, v in lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), "db", null), "subnet_ids", null) : v.id]

  app_subnets_cidr_block = [for k, v in lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), "app", null), "subnet_ids", null) : v.cidr_block]

  #private_alb_dns = lookup(lookup(lookup(module.alb, "private" , null), "alb" , null) , "dns_name" ,null)
  #private_lb_arn  = lookup(lookup(lookup(module.alb, "private" ,null), "listener" , null) , "arn" , null)

  #public_alb_dns = lookup(lookup(lookup(module.alb, "public" , null), "alb" , null) , "dns_name" ,null)
  #public_lb_arn  = lookup(lookup(lookup(module.alb, "public" ,null), "listener" , null) , "arn" , null)
}