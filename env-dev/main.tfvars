vpc = {
  main = {
    cidr = "10.0.0.0/16"
    subnets = {
      public = {
        public1 = { az = "us-east-1a", cidr = "10.0.0.0/24" }
        public2 = { az = "us-east1b", cidr = "10.0.1.0/24" }
      }
      app = {
        app1 = { az = "us-east-1a", cidr = "10.0.2.0/24" }
        app2 = { az = "us-east1b", cidr = "10.0.3.0/24" }
      }
      db = {
        db1 = { az = "us-east-1a", cidr = "10.0.4.0/24" }
        db2 = { az = "us-east-1b", cidr = "10.0.5.0/24" }
      }
    }
  }
}

