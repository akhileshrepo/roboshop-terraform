output "vpc" {
  value = module.vpc
}

output "default_vpc_id" {
  value = data.aws_subnets.subnets.ids
}

output "app_subnets" {
  value = local.app_subnets
}