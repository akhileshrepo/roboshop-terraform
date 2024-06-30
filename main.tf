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

  for_each                   = var.alb
  lb_type                    = each.value["lb_type"]
  internal                   = each.value["internal"]
  sg_ingress_cidr            = each.value["sg_ingress_cidr"]
  vpc_id                     = each.value["internal"] ? local.vpc_id : var.default_vpc_id
  subnets                    = each.value["internal"] ? local.app_subnets : data.aws_subnets.subnets.ids
  tags                       = var.tags
  env                        = var.env
  sg_port                    = each.value["sg_port"]
}

module "docdb" {
  source                    = "git::https://github.com/akhileshrepo/tf-module-docdb.git"
  tags                      = var.tags
  env                       = var.env

  for_each                  = var.docdb
  subnet_ids                = local.db_subnets
  backup_retention_period   = each.value["backup_retention_period"]
  preferred_backup_window   = each.value["preferred_backup_window"]
  skip_final_snapshot       = each.value["skip_final_snapshot"]
  vpc_id                    = local.vpc_id
  sg_ingress_cidr           = local.app_subnets_cidr
  engine_version            = each.value["engine_version"]
}

