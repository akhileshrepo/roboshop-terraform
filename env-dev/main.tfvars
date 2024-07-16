default_vpc_id              = "vpc-0bb2ad876599ca0f1"
default_vpc_cidr            = "172.31.0.0/16"
default_vpc_route_table_id  = "rtb-058289fa903d901c4"
zone_id                     = "Z093842334KRCLE5WWCFA"
env                         = "dev"
ssh_ingress_cidr            = ["172.31.46.100/32"]
az                          = ["us-east-1a", "us-east-1b"]
monitoring_ingress_cidr     =  ["172.31.83.153/32"]

tags = {
  company_name  = "ABC Tech"
  business_unit = "Ecommerce"
  project_name  = "roboshop"
  cost_center   = "ecom_rs"
  created_by    = "terraform"
}


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

alb = {
  public = {
    internal        = false
    lb_type         = "application"
    sg_ingress_cidr = ["0.0.0.0/0"]
    sg_port         = 80
  }

  private = {
    internal        = true
    lb_type         = "application"
    sg_ingress_cidr = ["172.31.0.0/16", "10.0.0.0/16"]
    sg_port         = 80
  }
}

docdb = {
  main = {
    backup_retention_period = 5
    preferred_backup_window = "07:00-09:00"
    skip_final_snapshot     = true
    engine_version          = "4.0.0"
    engine_family           = "docdb4.0"
    instance_class          = "db.t3.medium"
    instance_count          = 2
  }
}

rds = {
  main = {
    rds_type = "mysql"
    db_port  = 3306
    engine_family = "aurora-mysql5.7"
    engine        = "aurora-mysql"
    engine_version = "5.7.mysql_aurora.2.11.3"
    backup_retention_period = 5
    preferred_backup_window = "07:00-09:00"
    skip_final_snapshot     = true
    instance_count          = 2
    instance_class          = "db.t3.small"
  }
}

elasticache = {
  main = {
    elasticache_type = "redis"
    family           = "redis6.x"
    port             = 6379
    engine           = "redis"
    node_type        = "cache.t3.micro"
    num_cache_nodes  = 1
    engine_version   = "6.2"
  }
}

rabbitmq = {
  main = {
    instance_type = "t3.micro"
  }
}

apps = {
  frontend = {
    instance_type    = "t3.small"
    port             = 80
    desired_capacity = 1
    max_size         = 3
    min_size         = 1
    lb_priority      = 1
    lb_type          = "public"
    parameters       = []
    tags             = { Monitor_Nginx = "yes" }
  }
  catalogue = {
    instance_type    = "t3.small"
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
    instance_type    = "t3.micro"
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
    instance_type    = "t3.micro"
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
    instance_type    = "t3.micro"
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
    instance_type    = "t3.micro"
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