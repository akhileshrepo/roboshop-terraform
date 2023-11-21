module "vpc" {
    for_each = var.vpc
    source = "git::https://github.com/akhileshrepo/tf-module-vpc.git"
    cidr = each.value["cidr"]
    subnets = each.value["subnets"]
    vpc_default_vpc_id = var.vpc_default_vpc_id
    default_vpc_cidr = var.default_vpc_cidr
    default_vpc_route_table_id = var.default_vpc_route_table_id
    tags                       = var.tags
    env                        = var.env
}

output "vpc" {
    value = module.vpc
}

