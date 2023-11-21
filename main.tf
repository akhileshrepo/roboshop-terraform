module "components" {
    for_each = var.vpc
    source = "git::https://github.com/akhileshrepo/tf-module-vpc"
    cidr = each.value{"cidr"}
    subnets = each.value{"subnets"}
}