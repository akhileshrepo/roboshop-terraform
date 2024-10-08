module "vpc" {
  source                      = "git::https://github.com/akhileshrepo/tf-module-vpc.git"

  for_each                    = var.vpc
  cidr                        = each.value["cidr"]
  subnets                     = each.value["subnets"]
  default_vpc_id              = var.default_vpc_id
  default_vpc_cidr            = var.default_vpc_cidr
  default_vpc_route_table_id  = var.default_vpc_route_table_id
  tags                        = var.tags
  env                         = var.env
}
#
# # module "alb" {
# #  source                       = "git::https://github.com/akhileshrepo/tf-module-alb.git"
# #
# #  for_each                     = var.alb
# #  internal                     = each.value["internal"]
# #  lb_type                      = each.value["lb_type"]
# #  sg_ingress_cidr              = each.value["sg_ingress_cidr"]
# #  vpc_id                       = each.value["internal"] ? local.vpc_id : var.default_vpc_id
# #  subnets                      = each.value["internal"] ? local.app_subnets : data.aws_subnets.subnets.ids
# #  tags                         = var.tags
# #  env                          = var.env
# #  sg_port                      = each.value["sg_port"]
# #   acm_certificate_arn         = var.acm_certificate_arn
# # }

module "docdb" {
  source                      = "git::https://github.com/akhileshrepo/tf-module-docdb.git"
  tags                        = var.tags
  env                         = var.env

  for_each                    = var.docdb
  subnet_ids                  = local.db_subnets
  backup_retention_period     = each.value["backup_retention_period"]
  preferred_backup_window     = each.value["preferred_backup_window"]
  skip_final_snapshot         = each.value["skip_final_snapshot"]
  vpc_id                      = local.vpc_id
  sg_ingress_cidr             = local.app_subnets_cidr
  engine_version              = each.value["engine_version"]
  engine_family               = each.value["engine_family"]
  instance_count              = each.value["instance_count"]
  instance_class              = each.value["instance_class"]
  kms_key_id                  = var.kms_key_id
}

module "rds" {
  source                      = "git::https://github.com/akhileshrepo/tf-module-rds.git"
  tags                        = var.tags
  env                         = var.env

  for_each                    = var.rds
  rds_type                    = each.value["rds_type"]
  subnet_ids                  = local.db_subnets
  sg_ingress_cidr             = local.app_subnets_cidr
  db_port                     = each.value["db_port"]
  vpc_id                      = local.vpc_id
  engine_family               = each.value["engine_family"]
  engine                      = each.value["engine"]
  engine_version              = each.value["engine_version"]
  backup_retention_period     = each.value["backup_retention_period"]
  preferred_backup_window     = each.value["preferred_backup_window"]
  instance_count              = each.value["instance_count"]
  instance_class              = each.value["instance_class"]
  skip_final_snapshot         = each.value["skip_final_snapshot"]
  kms_key_id                  = var.kms_key_id
}

module "elasticache" {
  source                          = "git::https://github.com/akhileshrepo/tf-module-elasticache.git"
  tags                            = var.tags
  env                             = var.env

  for_each                        = var.elasticache
  elasticache_type                = each.value["elasticache_type"]
  vpc_id                          = local.vpc_id
  sg_ingress_cidr                 = local.app_subnets_cidr
  subnet_ids                      = local.app_subnets
  family                          = each.value["family"]
  port                            = each.value["port"]
  engine                          = each.value["engine"]
  node_type                       = each.value["node_type"]
  num_cache_nodes                 = each.value["num_cache_nodes"]
  engine_version                  = each.value["engine_version"]
}

module "rabbitmq" {
  source                          = "git::https://github.com/akhileshrepo/tf-module-rabbitmq.git"
  tags                            = var.tags
  env                             = var.env

  for_each                        = var.rabbitmq
  subnet_ids                      = local.db_subnets
  vpc_id                          = local.vpc_id
  sg_ingress_cidr                 = local.app_subnets_cidr
  instance_type                   = each.value["instance_type"]
  ssh_ingress_cidr                = var.ssh_ingress_cidr
  zone_id                         = var.zone_id
  kms_key_id                      = var.kms_key_id
}

# # module "app" {
# #  depends_on = [module.docdb, module.alb, module.elasticache, module.rabbitmq, module.rds]
# #  source     = "git::https://github.com/akhileshrepo/tf-module-app.git"
# #
# #  tags                    = merge(var.tags, each.value["tags"])
# #  env                     = var.env
# #  zone_id                 = var.zone_id
# #  ssh_ingress_cidr        = var.ssh_ingress_cidr
# #  default_vpc_id          = var.default_vpc_id
# #  monitoring_ingress_cidr = var.monitoring_ingress_cidr
# #  az                      = var.az
# #  kms_key_id              = var.kms_key_id
# #
# #  for_each         = var.apps
# #  component        = each.key
# #  port             = each.value["port"]
# #  instance_type    = each.value["instance_type"]
# #  desired_capacity = each.value["desired_capacity"]
# #  max_size         = each.value["max_size"]
# #  min_size         = each.value["min_size"]
# #  lb_priority      = each.value["lb_priority"]
# #  parameters       = each.value["parameters"]
# #
# #  sg_ingress_cidr = local.app_subnets_cidr
# #  vpc_id          = local.vpc_id
# #  subnet_ids      = local.app_subnets
# #
# #  private_alb_name = lookup(lookup(lookup(module.alb, "private", null), "alb", null), "dns_name", null)
# #  public_alb_name  = lookup(lookup(lookup(module.alb, "public", null), "alb", null), "dns_name", null)
# #  private_listener = lookup(lookup(lookup(module.alb, "private", null), "listener", null), "arn", null)
# #  public_listener  = lookup(lookup(lookup(module.alb, "public", null), "listener", null), "arn", null)
# # }
#
# # resource "aws_instance" "load_runner" {
# #   ami           = data.aws_ami.ami.id
# #   vpc_security_group_ids = ["sg-0ad8ec6873fafd140"]
# #   instance_type = "t3.medium"
# #   tags = {
# #     Name = "load-runner"
# #   }
# # }
#
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "prod-roboshop"
  cluster_version = "1.28"

  cluster_endpoint_public_access  = false

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = local.vpc_id
  subnet_ids               = local.app_subnets
  control_plane_subnet_ids = local.app_subnets


  eks_managed_node_groups = {
    green = {
      min_size     = 1
      max_size     = 10
      desired_size = 3

      instance_types = ["t3.large"]
      capacity_type  = "SPOT"
    }
  }

  tags = var.tags
}

resource "aws_security_group_rule" "https-to-eks" {
  from_port         = 443
  protocol          = "tcp"
  security_group_id = module.eks.cluster_security_group_id
  to_port           = 443
  type              = "ingress"
  cidr_blocks       = var.ssh_ingress_cidr
}

resource "aws_iam_role" "eks-ssm" {
  name = "${var.env}-eks-ssm-ro"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": "${module.eks.oidc_provider_arn}"
        },
        "Action": "sts:AssumeRoleWithWebIdentity",
        "Condition": {
          "StringEquals": {
            "${module.eks.oidc_provider}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })

  inline_policy {
    name = "${var.env}-eks-ssm-ro"

    policy = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "VisualEditor0",
          "Effect" : "Allow",
          "Action" : [
            "kms:Decrypt",
            "ssm:GetParameterHistory",
            "ssm:GetParametersByPath",
            "ssm:GetParameters",
            "ssm:GetParameter"
          ],
          "Resource" : "*"
        },
        {
          "Sid" : "VisualEditor1",
          "Effect" : "Allow",
          "Action" : "ssm:DescribeParameters",
          "Resource" : "*"
        }
      ]
    })
  }
}