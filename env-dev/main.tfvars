vpc = {
    main = {
        cidr = "10.0.0.0/24"
        subnets = {
            public = {
                public1 = {cidr = "10.0.0.0/24", az = "us-east1a"}
                public2 = {cidr = "10.0.1.0/24", az = "us-east1b"}
            }
            app = {
                public1 = {cidr = "10.0.2.0/24", az = "us-east1a"}
                public2 = {cidr = "10.0.3.0/24", az = "us-east1b"}
            }
            db = {
                public1 = {cidr = "10.0.4.0/24", az = "us-east1a"}
                public2 = {cidr = "10.0.5.0/24", az = "us-east1b"}
            }
            
        }
    }
}