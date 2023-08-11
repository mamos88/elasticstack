# resource "aws_autoscaling_group" "NomadAmazonLinuxClientASG" {
#     name = "NomadAmazonLinuxClientASG"
#     max_size = 0
#     min_size = 0

#     vpc_zone_identifier = [for subnet in aws_subnet.nomad-lab-pub: subnet.id]
    
#     launch_template {
#         id = aws_launch_template.NomadAmazonLinuxClientLC.id
#         version = "$Latest"
#     }

#     target_group_arns = ["${aws_lb_target_group.test.arn}"]

#     tag {
#       key = "Name"
#       value = "NomadClient-AmazonLinux"
#       propagate_at_launch = true
#     }
# }

# resource "aws_autoscaling_group" "UbuntuLinuxClientASG" {
#     name = "UbuntuLinuxClientASG"
#     max_size = 0
#     min_size = 0

#     vpc_zone_identifier = [for subnet in aws_subnet.nomad-lab-pub: subnet.id]
    
#     launch_template {
#         id = aws_launch_template.UbuntuLinuxClientLC.id
#         version = "$Latest"
#     }

#     target_group_arns = ["${aws_lb_target_group.test.arn}"]

#     tag {
#       key = "Name"
#       value = "NomadClient-UbuntuLinux"
#       propagate_at_launch = true
#     }
# }