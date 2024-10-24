resource "aws_vpc" "foodbox-vpc-vp" {
  cidr_block = var.cidr_vpc
  enable_dns_hostnames = true

   tags = {
    Name = "foodbox-vpc-vp"
    Owner = "Vincent Panouilleres"
  }
}