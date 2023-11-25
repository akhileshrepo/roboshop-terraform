###This is default values
default_vpc_id             = "vpc-06b432e74a6c1b5c5"
default_vpc_cidr           = "172.31.0.0/16"
default_vpc_route_table_id = "rtb-0056ec6a7d1ceee5b"
zone_id                    = "Z0929615AH1MSD5PXATC"
env                        = "dev"
ssh_ingress_cidr           = ["172.31.39.31/32"]
acm_certificate_arn        = ["arn:aws:acm:us-east-1:467609026719:certificate/c386eb5f-13dc-485a-91db-6a2854763326"]
kms_key_id                 = "arn:aws:kms:us-east-1:633788536644:key/dce90622-5a23-4f82-a639-be841f534702"


###Tags for resources in resource Group
tags = {
  company_name  = "ABC Tech"
  business_unit = "Ecommerce"
  project_name  = "robotshop"
  cost_center   = "ecom_rs"
  created_by    = "terraform"
}

###VPC network range
vpc = {
  main = {
    cidr = "10.0.0.0/16"
    subnets = {
      public = {
        public1 = { cidr = "10.0.0.0/24", az = "us-east-1a" }
        public2 = { cidr = "10.0.1.0/24", az = "us-east-1b" }
      }
      app = {
        app1 = { cidr = "10.0.2.0/24", az = "us-east-1a" }
        app2 = { cidr = "10.0.3.0/24", az = "us-east-1b" }
      }
      db = {
        db1 = { cidr = "10.0.4.0/24", az = "us-east-1a" }
        db2 = { cidr = "10.0.5.0/24", az = "us-east-1b" }
      }
    }
  }
}

###Application Load balancer configuration includes both private and public
alb = {
  public = {
    internal        = false
    lb_type         = "application"
    sg_ingress_cidr = ["0.0.0.0/0"]
    sg_port         = 443
  }

  private = {
    internal        = true
    lb_type         = "application"
    sg_ingress_cidr = ["172.31.0.0/16", "10.0.0.0/16"]
    sg_port         = 80
  }
}

###Document DB configuration
docdb = {
  main = {
    backup_retention_period = 5
    preferred_backup_window = "07:00-09:00"
    skip_final_snapshot     = true
    engine_version          = "4.0.0"
    engine_family           = "docdb4.0"
    instance_count          = 1
    instance_class          = "db.t2.medium"
  }
}

### MYSQL database configuration
rds = {
  main = {
    rds_type                = "mysql"
    db_port                 = 3306
    engine_family           = "aurora-mysql5.7"
    engine                  = "aurora-mysql"
    engine_version          = "5.7.mysql_aurora.2.11.3"
    backup_retention_period = 5
    preferred_backup_window = "07:00-09:00"
    skip_final_snapshot     = true
    instance_count          = 1
    instance_class          = "db.t2.small"
  }
}

###Redis database configuration
elasticache = {
  main = {
    elasticache_type = "redis"
    family           = "redis6.x"
    port             = 6379
    engine           = "redis"
    node_type        = "cache.t2.micro"
    num_cache_nodes  = 1
    engine_version   = "6.2"
  }
}


###Rabbitmq server configuration
rabbitmq = {
  main = {
    instance_type = "t3.small"
  }
}

### App server configuration
apps = {
  frontend = {
    instance_type    = "t2.micro"
    port             = 80
    desired_capacity = 1
    max_size         = 3
    min_size         = 1
    lb_priority      = 1
    lb_type          = "public"
    parameters       = []
    tags             = {}
  }
  catalogue = {
    instance_type    = "t2.micro"
    port             = 8080
    desired_capacity = 1
    max_size         = 3
    min_size         = 1
    lb_priority      = 2
    lb_type          = "private"
    parameters       = ["docdb"]
    tags             = {}
  }
  user = {
    instance_type    = "t2.micro"
    port             = 8080
    desired_capacity = 1
    max_size         = 3
    min_size         = 1
    lb_priority      = 3
    lb_type          = "private"
    parameters       = ["docdb"]
    tags             = {}
  }
  cart = {
    instance_type    = "t2.micro"
    port             = 8080
    desired_capacity = 1
    max_size         = 3
    min_size         = 1
    lb_priority      = 4
    lb_type          = "private"
    parameters       = []
    tags             = {}
  }
  payment = {
    instance_type    = "t2.micro"
    port             = 8080
    desired_capacity = 1
    max_size         = 3
    min_size         = 1
    lb_priority      = 5
    lb_type          = "private"
    parameters       = ["rabbitmq"]
    tags             = {}
  }
  shipping = {
    instance_type    = "t2.micro"
    port             = 8080
    desired_capacity = 1
    max_size         = 3
    min_size         = 1
    lb_priority      = 6
    lb_type          = "private"
    parameters       = ["rds"]
    tags             = {}
  }
}