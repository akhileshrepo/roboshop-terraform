module "components" {
  source = "git::https://github.com/akhileshrepo/tf-module-vpc.git"

  for_each = var.vpc
  cidr = lookup(each.value, "cidr", null)
}
