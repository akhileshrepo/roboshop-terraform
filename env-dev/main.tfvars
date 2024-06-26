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
default_route_table_id = "rtb-058289fa903d901c4"

tags = {
  company_name = "ABC Tech"
  business_unit = "Ecommerce"
  project_name = "roboshop"
  cost_center = "ecom_rs"
  created_by = "terraform"
}

env = "dev"