

output "vpc" {
  value = module.vpc
}


output "subnets" {
  value = data.aws_subnets.subnets.ids
}
