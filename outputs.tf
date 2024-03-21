
/*
output "vpc" {
  value = module.vpc
}
*/

output "vpc" {
  value = data.aws_subnets.subnets.ids
}
