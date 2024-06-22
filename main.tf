module "instances" {
  source                  = "git::https://github.com/akhileshrepo/tf-module-basic-test.git"
  for_each                = var.components
  vpc_security_group_ids  = var.vpc_security_group_ids
  zone_id                 = var.zone_id
  name                    = lookup(each.value, "name", null)
  instance_type           = lookup(each.value, "instance_type", null)
}
