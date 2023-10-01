module "components" {
    for_each           = var.vpc
    source             = "git::https://github.com/akhileshrepo/tf-module-vpc.git"
}   cidr               = each.value["cidr"]