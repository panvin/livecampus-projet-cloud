resource "aws_launch_template" "foodbox-ec2-template-vp" {
    depends_on = [ aws_db_instance.foodbox-rds-vp, aws_efs_file_system.foodbox-efs-vp ]
    name_prefix   = "foodbox-ec2-template-vp"
    image_id      = "ami-00385a401487aefa4"
    instance_type = "t3a.small"
    user_data     = base64encode(templatefile("user_data.sh", {
        efs_id      = "${aws_efs_file_system.foodbox-efs-vp.id}"
        wp_version  = "${var.wp_version}", 
        db_name     = "${var.db_name}",
        db_user     = "${var.db_user}",
        db_password = "${var.db_password}",
        db_endpoint = "${aws_db_instance.foodbox-rds-vp.endpoint}"
    }))
    key_name      = "foodbox-debug-vp"

    block_device_mappings {
        device_name = "/dev/xvda"
        ebs {
          volume_size = 10
          volume_type = "gp3"
        }
    } 

    network_interfaces {
        security_groups = [aws_security_group.foodbox-sg-ec2-vp.id]
    }

    tag_specifications {
        resource_type = "instance"
        tags = {
            Name = "foodbox-wordpress-instance-vp"
            Owner = "Vincent Panouilleres"
        }
    }

    tags = {
        Name = "foodbox-ec2-template-vp"
        Owner = "Vincent Panouilleres"
    }
}

resource "aws_autoscaling_group" "foodbox-autoscaling-group-vp" {
    depends_on          = [ aws_db_instance.foodbox-rds-vp, aws_efs_file_system.foodbox-efs-vp ]
    desired_capacity    = var.ec2_desired_capacity
    max_size            = var.ec2_max_instances
    min_size            = var.ec2_min_instances
    target_group_arns   = [aws_lb_target_group.foodbox-lb-tg-vp.arn]
    vpc_zone_identifier = aws_subnet.foodbox-subnet-pub-vp.*.id

    launch_template {
        id      = aws_launch_template.foodbox-ec2-template-vp.id
        version = "$Latest"
    }
}