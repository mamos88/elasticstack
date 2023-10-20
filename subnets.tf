# Data source to retrieve subnet information
data "aws_subnets" "elasticsearch-lab" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.elasticsearch-lab-vpc.id]
  }
}

data "aws_subnet" "elasticsearch-lab" {
  # for_each = sort(toset(data.aws_subnets.elasticsearch-lab.ids))
  for_each = { for idx, subnet_id in data.aws_subnets.elasticsearch-lab.ids: idx => subnet_id }
  id      = each.value
}

locals {
  subnet_ids = { for key, subnet in data.aws_subnet.elasticsearch-lab : key => subnet.id }
}