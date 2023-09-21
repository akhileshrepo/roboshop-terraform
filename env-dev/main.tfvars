components = {
    frontend = {
        name = "frontend"
        instance_type = "t2.micro"
    }
    cart = {
        name = "cart"
        instance_type = "t2.micro"
    }
    catalogue = {
        name = "catalogue"
        instance_type = "t2.micro"
    }
    mongodb = {
        name = "mongodb"
        instance_type = "t2.micro"
    }
    user = {
        name = "user"
        instance_type = "t2.micro"
    }
    redis = {
        name = "redis"
        instance_type = "t2.micro"
    }
    mysql = {
        name = "mysql"
        instance_type = "t2.micro"
    }
    payment = {
        name = "payment"
        instance_type = "t2.micro"
    }
    shipping = {
        name = "shipping"
        instance_type = "t2.micro"
    }
    rabbitmq = {
        name = "rabbitmq"
        instance_type = "t2.micro"
    }
}

security_groups = [	"sg-0d3e4cc237236453f" ]
zone_id = "Z045851830X54L3IRT9GH"