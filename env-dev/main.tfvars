default_vpc_id         = "vpc-05642ce42b99a7fae"
default_cidr           = "172.31.0.0/16"
default_route_table_id = "rtb-0dbc8b1b5e435955e"
ssh_ingress_cidr       = ["172.31.94.218/32"]
zone_id                = "Z09760323G7SC2VABFTOY"


env  = "dev"

tags = {
  company_name  = "ABC tech"
  business_unit = "ecommerce"
  project_name  = "robotshop"
  cost_centrt   = "ecom rs"
  created_by    = "terraform"
}

vpc = {
  main = {
    cidr = "10.0.0.0/16"
    subnets ={
      public = {
        public1 = { cidr = "10.0.0.0/24" , az   = "us-east-1a" }
        public2 = { cidr = "10.0.1.0/24" , az  = "us-east-1b"  }
      }
      app = {
        app1 = { cidr = "10.0.2.0/24" , az   = "us-east-1a" }
        app2 = { cidr = "10.0.3.0/24" , az   = "us-east-1b" }
      }
      db  = {
        db1 = { cidr = "10.0.4.0/24" , az   = "us-east-1a" }
        db2 = { cidr = "10.0.5.0/24" , az   = "us-east-1b" }
      }
    }
  }
}


alb  = {
  public = {
    internal = false
    lb_type  = "application"
    sg_cidr_blocks = ["0.0.0.0/16"]
    sg_port = 80
  }
  private = {
    internal = true
    lb_type  = "application"
    sg_cidr_blocks = ["10.0.0.0/16", "172.31.0.0/16"]
    sg_port = 80
  }
}

docdb = {
  main = {
    backup_retention_period = 5
    preferred_backup_window = "07:00-09:00"
    skip_final_snapshot     = true
    family                  = "docdb4.0"
    engine_version          = "4.0.0"
    instance_count          = 1
    instance_class          = "db.t3.medium"
  }
}

rds = {
  main = {
    rds_type       = "mysql"
    ingres_port    = 3306
    engine         = "aurora-mysql"
    family         = "aurora-mysql5.7"
    engine_version = "5.7.mysql_aurora.2.11.3"
    backup_retention_period = 5
    preferred_backup_window = "07:00-09:00"
    skip_final_snapshot     = true
    instance_count  = 1
    instance_class  = "db.t3.small"
  }
}

elasticache = {
  main = {
    pg_family = "redis6.x"
    engine    = "redis"
    dbport    = 6379
    node_type = "cache.t3.micro"
    num_cache_nodes = 1
    engine_version  = "6.2"
  }
}

rabbitmq  = {
  main = {
    instance_type = "t3.micro"
  }
}

apps = {
  frontend = {
    app_port         = 80
    instance_type    = "t3.micro"
    desired_capacity = 1
    max_size         = 3
    min_size         = 1
    lb_priority      = 1
  }
  catalogue = {
    app_port         = 80
    instance_type    = "t3.micro"
    desired_capacity = 1
    max_size         = 3
    min_size         = 1
    lb_priority      = 2
  }
  user  = {
    app_port         = 80
    instance_type    = "t3.micro"
    desired_capacity = 1
    max_size         = 3
    min_size         = 1
    lb_priority      = 3
  }
  cart = {
    app_port         = 80
    instance_type    = "t3.micro"
    desired_capacity = 1
    max_size         = 3
    min_size         = 1
    lb_priority      = 4
  }
  shipping = {
    app_port         = 80
    instance_type    = "t3.micro"
    desired_capacity = 1
    max_size         = 3
    min_size         = 1
    lb_priority      = 5
  }
  payment = {
    app_port         = 80
    instance_type    = "t3.micro"
    desired_capacity = 1
    max_size         = 3
    min_size         = 1
    lb_priority      = 6
  }

}
