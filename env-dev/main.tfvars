vpc = {
  main = {
    cidr = "10.0.0.0/16"
    subnets = {
      public = {
        public1 = { "az" = "us-east-1a", "cidr" = "10.0.0.0/24" }
        public2 = { "az" = "us-east-1b", "cidr" = "10.0.1.0/24" }
      }
      app = {
        app1 = { "az" = "us-east-1a", "cidr" = "10.0.2.0/24" }
        app2 = { "az" = "us-east-1b", "cidr" = "10.0.3.0/24" }
      }
      db = {
        db1 = { "az" = "us-east-1a", "cidr" = "10.0.4.0/24" }
        db2 = { "az" = "us-east-1b", "cidr" = "10.0.5.0/24" }
      }
    }
  }
}

default_vpc_id = "vpc-0bb2ad876599ca0f1"
default_vpc_cidr = "172.31.0.0/16"
default_vpc_route_table_id = "rtb-058289fa903d901c4"
env = "dev"

tags = {
  company_name = "ABC Tech"
  business_unit = "Ecommerce"
  project_name = "roboshop"
  cost_center = "ecom_rs"
  created_by = "terraform"
}

alb = {
  public = {
    internal            = false
    lb_type             = "application"
    sg_ingress_cidr     = ["0.0.0.0/0"]
    sg_port             = 80
  }
  private = {
    internal            = true
    lb_type             = "application"
    sg_ingress_cidr     = ["172.31.0.0/16", "10.0.0.0/16"]
    sg_port             = 80
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