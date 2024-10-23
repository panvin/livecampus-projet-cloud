data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "foodbox-subnet-pub-vp" {
    count                   = length(var.cidr_public_subnet)
    vpc_id                  = aws_vpc.foodbox-vpc-vp.id
    cidr_block              = var.cidr_public_subnet[count.index]
    availability_zone       = data.aws_availability_zones.available.names[count.index % 3]
    map_public_ip_on_launch = true
    
    
    tags = {
        Name = "foodbox-subnet-pub-vp-${count.index + 1}"
        Owner = "Vincent Panouilleres"
  }
}

resource "aws_subnet" "foodbox-subnet-pri-vp" {
    count             = length(var.cidr_private_subnet)
    vpc_id            = aws_vpc.foodbox-vpc-vp.id
    cidr_block        = var.cidr_private_subnet[count.index]
    availability_zone = data.aws_availability_zones.available.names[count.index % 3]

    tags = {
        Name = "foodbox-subnet-pri-vp"
        Owner = "Vincent Panouilleres"
    }
}

resource "aws_db_subnet_group" "foodbox-rds-subnet-group-vp" {
    name = "foodbox-rds-subnet-group-vp"
    subnet_ids = aws_subnet.foodbox-subnet-pri-vp.*.id

    tags = {
        Name  = "foodbox-rds-subnet-group-vp"
        Owner = "Vincent PANOUILLERES" 
  } 
}
