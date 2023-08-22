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

default_vpc_id = "vpc-05642ce42b99a7fae"
default_cidr   = "172.31.0.0/16"
default_route_table_id = "rtb-0dbc8b1b5e435955e"

env  = "dev"
tags = {
  company_name  = "ABC tech"
  business_unit = "ecommerce"
  project_name  = "robotshop"
  cost_centrt   = "ecom rs"
  created_by    = "terraform"
}

#sg_port = 80
#alb  = {
#  public = {
#    internal = false
#    lb_type  = "application"
#    sg_group = ["0.0.0.0/16"]


#  }
#  private = {
#    internal = false
#    lb_type  = "application"
#    sg_group = ["10.0.0.0/16","172.31.0.0/16"]


#  }
#}
