module "vpc" {
    for_each = var.vpc
    source = "git::https://github.com/akhileshrepo/tf-module-vpc.git"
    cidr = each.value["cidr"]
    subnets = each.value["subnets"]
    default_vpc_id = var.vpc_default_vpc_id
    default_vpc_cidr = var.default_vpc_cidr
    default_vpc_route_table_id = var.default_vpc_route_table_id
}

output "vpc" {
    value = module.vpc
}

default_vpc_id = "vpc-06b432e74a6c1b5c5"
default_vpc_cidr = "172.31.0.0/16"
default_vpc_route_table_id = "rtb-0056ec6a7d1ceee5b"