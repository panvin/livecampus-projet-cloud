resource "aws_efs_file_system" "foodbox-efs-vp" {
   creation_token = "foodbox-efs-vp"
   performance_mode = "generalPurpose"
   throughput_mode = "bursting"
   encrypted = "true"
 tags = {
     Name   = "foodbox-efs-vp"
     Owner  = "Vincent PANOUILLERES"
   }
 }


resource "aws_efs_mount_target" "foodbox-efs-mt-vp" {
   count            = length(var.cidr_public_subnet)
   file_system_id   = aws_efs_file_system.foodbox-efs-vp.id
   subnet_id        = aws_subnet.foodbox-subnet-pub-vp[count.index].id
   security_groups  = [aws_security_group.foodbox-sg-efs-vp.id]

 }