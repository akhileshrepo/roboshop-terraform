vpc = {
  main = {
    cidr = "10.0.0.0/24"
    subnets = {
      public = {
        public1 = {cidr = "10.0.0.0/24", az = "us-east-1a"}
        public2 = {cidr = "10.0.1.0/24", az = "us-east-1b"}
      }
      app = {
        app1 = {cidr = "10.0.2.0/24", az = "us-east-1a"}
        app2 = {cidr = "10.0.3.0/24", az = "us-east-1b"}
      }
      db = {
        db1 = {cidr = "10.0.4.0/24", az = "us-east-1a"}
        db2 = {cidr = "10.0.5.0/24", az = "us-east-1b"}
      }
    }
  }
}


default_vpc_id = "vpc-06b432e74a6c1b5c5"
default_vpc_cidr = "172.31.0.0/16"
default_vpc_route_table_id = "rtb-0056ec6a7d1ceee5b"
