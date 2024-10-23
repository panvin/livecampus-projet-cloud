# resource "aws_instance" "foodbox-debug-vp" {
#     ami               = "ami-00385a401487aefa4"
#     instance_type     = "t3a.small"
#     availability_zone = "eu-west-1a"
    
#     network_interface {
#         network_interface_id = aws_network_interface.foodbox-debug-if-vp.id
#         device_index         = 0
#     }

#     key_name = "foodbox-debug-vp"

#     tags = {
#         Name = "foodbox-debug-vp"
#         Owner = "Vincent Panouilleres"
#     }
# }

# resource "aws_network_interface" "foodbox-debug-if-vp" {
#   subnet_id   = aws_subnet.foodbox-subnet-pub-vp[0].id
#   security_groups = [aws_security_group.foodbox-sg-debug-vp.id]

#   tags = {
#     Name = "foodbox-debug-if-vp"
#     Owner = "Vincent Panouilleres"
#   }
# }