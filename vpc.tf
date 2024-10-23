resource "aws_vpc" "foodbox-vpc-vp" {
  cidr_block = "10.0.0.0/16"

   tags = {
    Name = "foodbox-vpc-vp"
    Owner = "Vincent Panouilleres"
  }
}