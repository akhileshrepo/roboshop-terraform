data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "Centos-8-DevOps-Practice"
  owners      = ["973714476881"]
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [var.default_vpc_id]
  }
}

