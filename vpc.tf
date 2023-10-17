# resource "aws_vpc" "elasticsearch-lab-vpc" {
#   cidr_block       = "10.0.0.0/16"
#   instance_tenancy = "default"
#   # enable_classiclink   = "false"
#   enable_dns_support   = "true"
#   enable_dns_hostnames = "true"

#   tags = {
#     Name      = "elasticsearch-lab"
#     Terraform = "true"
#   }
# }

# Data source to retrieve VPC information
data "aws_vpc" "elasticsearch-lab-vpc" {
  filter {
    name   = "tag:Name"
    values = ["base_network-lab"]
  }
}