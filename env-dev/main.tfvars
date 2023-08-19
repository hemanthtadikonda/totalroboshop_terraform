vpc =  "10.0.0.0/16"

subnets ={
  public = {
    public1 = { cidr = "10.0.0.0/24" , az   = "us-east-1a" }
    public2 = { cidr = "10.0.1.0/24" , az  = "us-east-1b"  }
  }
}
