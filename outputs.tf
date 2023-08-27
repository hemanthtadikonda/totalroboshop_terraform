output "alb" {
  value = lookup(module.alb, "alb", null)
}