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
        from_port       = 80
        to_port         = 80
        security_groups = [aws_security_group.foodbox-sg-lb-vp.id]
    }

    ingress {
        protocol        = "tcp"
        from_port       = 22
        to_port         = 22
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
        from_port       = 3306
        to_port         = 3306
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

resource "aws_security_group" "foodbox-sg-efs-vp" {
    name        = "foodbox-sg-efs-vp"
    vpc_id      = aws_vpc.foodbox-vpc-vp.id

    ingress {
        from_port       = 2049
        to_port         = 2049
        protocol        = "tcp"
        security_groups = [aws_security_group.foodbox-sg-ec2-vp.id]
    }
    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        security_groups = [aws_security_group.foodbox-sg-ec2-vp.id]
    }
    tags = {
        Name = "foodbox-sg-efs-vp"
        Owner = "Vincent Panouilleres"
    }
}