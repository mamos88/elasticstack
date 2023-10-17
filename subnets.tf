# Data source to retrieve subnet information
data "aws_subnets" "elasticsearch-lab" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.elasticsearch-lab-vpc.id]
  }
}

data "aws_subnet" "elasticsearch-lab" {
  for_each = toset(data.aws_subnets.elasticsearch-lab.ids)
  id      = each.value
}

locals {
  subnet_ids = { for key, subnet in data.aws_subnet.elasticsearch-lab : key => subnet.id }
}