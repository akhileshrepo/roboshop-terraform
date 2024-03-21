module "vpc" {
  source = "git::https://github.com/akhileshrepo/tf-module-vpc.git"

  for_each = var.vpc
  cidr = each.value["cidr"]
  subnets = each.value["subnets"]
}

















/*
module "vpc" {
  source = "git::https://github.com/akhileshrepo/tf-module-vpc.git"

  for_each                   = var.vpc
  cidr                       = each.value["cidr"]
  subnets                    = each.value["subnets"]
  default_vpc_id             = var.default_vpc_id
  default_vpc_cidr           = var.default_vpc_cidr
  default_vpc_route_table_id = var.default_vpc_route_table_id
  tags                       = var.tags
  env                        = var.env
}


module "alb" {
  source = "git::https://github.com/akhileshrepo/tf-module-alb.git"

  for_each = var.alb
  tags = var.tags
  env = var.env
  lb_type = each.value["lb_type"]
  internal = each.value["internal"]
  sg_ingress_cidr   = each.value["sg_ingress_cidr"]
  vpc_id = each.value["internal"] ? local.vpc_id : var.default_vpc_id
  subnets = each.value["internal"] ? local.app_subnets : data.aws_subnets.subnets.ids
  sg_port = each.value["sg_port"]
}
*/