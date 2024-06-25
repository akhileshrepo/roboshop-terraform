module "vpc" {
  source = "git::https://github.com/akhileshrepo/tf-module-vpc.git"

  for_each = var.vpc
  cidr = each.value["cidr"]
  subnets = each.value["subnets"]
}
