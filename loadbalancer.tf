resource "aws_lb" "foodbox-lb-vp" {
    name               = "foodbox-lb-vp"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.foodbox-sg-lb-vp.id]
    subnets            = aws_subnet.foodbox-subnet-pub-vp.*.id
    depends_on         = [aws_internet_gateway.foodbox-internet-gw-vp]
    
    tags = {
        Environment = "projet"
        Name = "foodbox-lb-vp"
        Owner = "Vincent Panouilleres"
    }
}

resource "aws_lb_target_group" "foodbox-lb-tg-vp" {
    name     = "foodbox-lb-tg-vp"
    port     = 80
    protocol = "HTTP"
    vpc_id   = aws_vpc.foodbox-vpc-vp.id  
}

resource "aws_lb_listener" "foodbox-lb-listener-vp" {
    load_balancer_arn = aws_lb.foodbox-lb-vp.arn
    port              = "80"
    protocol          = "HTTP"
    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.foodbox-lb-tg-vp.arn
    }
}