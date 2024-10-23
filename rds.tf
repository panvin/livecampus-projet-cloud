resource "aws_db_instance" "foodbox-rds-vp" {
    identifier             = "foodbox-rds-vp"
    instance_class         = "db.t3.micro"
    allocated_storage      = 5
    engine                 = var.db_engine
    engine_version         = var.db_engine_version
    db_name                = var.db_name
    username               = var.db_user
    password               = var.db_password
    db_subnet_group_name   = aws_db_subnet_group.foodbox-rds-subnet-group-vp.name
    vpc_security_group_ids = [aws_security_group.foodbox-sg-rds-vp.id]
    parameter_group_name   = aws_db_parameter_group.foodbox-db-parameter-group-vp.name
    multi_az               = false
    skip_final_snapshot    = true 
}

resource "aws_db_parameter_group" "foodbox-db-parameter-group-vp" {
    name   = "foodbox-db-parameter-group-vp"
    family = var.db_family

    parameter {
        name  = "character_set_server"
        value = "utf8"
    }

    parameter {
        name  = "character_set_client"
        value = "utf8"
    }
}
