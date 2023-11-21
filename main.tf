module "vpc" {
    for_each = var.vpc
    source = "git::https://github.com/akhileshrepo/tf-module-vpc.git"
    cidr = each.value{"cidr"}
    subnets = each.value{"subnets"}
    default_vpc_id = var.default_vpc_id
}

output "vpc" {
    value = module.vpc
}