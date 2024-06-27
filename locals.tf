locals {
  vpc_id = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
  app_subnets = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), "app", null), "subnet_ids", null)
}