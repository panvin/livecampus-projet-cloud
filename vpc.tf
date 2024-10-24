resource "aws_vpc" "foodbox-vpc-vp" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

   tags = {
    Name = "foodbox-vpc-vp"
    Owner = "Vincent Panouilleres"
  }
}