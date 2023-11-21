module "vpc" {
    for_each = var.vpc
    source = "git::https://github.com/akhileshrepo/tf-module-vpc.git"
    cidr = each.value{"cidr"}
    subnets = each.value{"subnets"}
}

output "vpc" {
        value = module.vpc
}