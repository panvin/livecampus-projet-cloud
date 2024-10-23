resource "aws_route_table" "foodbox-public-rt-vp" {
    vpc_id = aws_vpc.foodbox-vpc-vp.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.foodbox-internet-gw-vp.id
    }

    tags = {
        Name = "foodbox-public-rt-vp"
        Owner = "Vincent Panouilleres"
    }
}

resource "aws_route_table_association" "association-pub" {
    count          = length(var.cidr_public_subnet)  
    subnet_id      = aws_subnet.foodbox-subnet-pub-vp[count.index].id
    route_table_id = aws_route_table.foodbox-public-rt-vp.id
}

resource "aws_route_table" "foodbox-private-rt-vp" {
    vpc_id = aws_vpc.foodbox-vpc-vp.id

  tags = {
    Name = "foodbox-private-rt-vp-1"
    Owner = "Vincent Panouilleres"
  }
}

resource "aws_route_table_association" "association-pri-1" {
    count          = length(var.cidr_private_subnet)
    subnet_id      = aws_subnet.foodbox-subnet-pri-vp[count.index].id
    route_table_id = aws_route_table.foodbox-private-rt-vp.id
}