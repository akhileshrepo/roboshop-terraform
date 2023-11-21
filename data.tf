data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_default_vpc_id]
  }
}