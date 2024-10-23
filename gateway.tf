resource "aws_internet_gateway" "foodbox-internet-gw-vp" {
  vpc_id = aws_vpc.foodbox-vpc-vp.id

  tags = {
    Name = "foodbox-internet-gw-vp"
    Owner = "Vincent Panouilleres"
  }
}