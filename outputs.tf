output "alb" {
  value = lookup(lookup(lookup(module.alb, "private" , null), "alb" , null) , "dns_name" ,null
}
output "vpc" {
  value = module.vpc
}