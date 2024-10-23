resource "aws_security_group" "foodbox-sg-lb-vp" {
    name   = "foodbox-sg-lb-vp" 
    vpc_id = aws_vpc.foodbox-vpc-vp.id
  
    ingress {
        protocol         = "tcp"
        from_port        = 80
        to_port          = 80
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "foodbox-sg-lb-vp"
        Owner = "Vincent Panouilleres"
    }

}

resource "aws_security_group" "foodbox-sg-ec2-vp" {
    name   = "foodbox-sg-ec2-vp" 
    vpc_id = aws_vpc.foodbox-vpc-vp.id

    ingress {
        protocol        = "tcp"
        from_port       = 80 # range of
        to_port         = 80 # port numbers
        security_groups = [aws_security_group.foodbox-sg-lb-vp.id]
    }

    ingress {
        protocol        = "tcp"
        from_port       = 22 # range of
        to_port         = 22 # port numbers
        cidr_blocks     = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "foodbox-sg-ec2-vp"
        Owner = "Vincent Panouilleres"
    }
}

resource "aws_security_group" "foodbox-sg-rds-vp" {
    name   = "foodbox-sg-rds-vp" 
    vpc_id = aws_vpc.foodbox-vpc-vp.id

    ingress {
        protocol        = "tcp"
        from_port       = 3306 # range of
        to_port         = 3306 # port numbers
        cidr_blocks     = var.cidr_public_subnet     
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "foodbox-sg-rds-vp"
        Owner = "Vincent Panouilleres"
    }
}