resource "aws_internet_gateway" "elasticsearch-lab-igw" {
  vpc_id = aws_vpc.elasticsearch-lab-vpc.id

  tags = {
    Name      = "elasticsearch-in-aws"
    Terraform = "true"
  }
}

resource "aws_route_table" "elasticsearch-lab-public-crt" {
  vpc_id = aws_vpc.elasticsearch-lab-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.elasticsearch-lab-igw.id
  }

  tags = {
    Name      = "elasticsearch-in-aws"
    Terraform = "true"
  }
}

resource "aws_route_table_association" "subnet_association" {
  count = 3

  subnet_id      = aws_subnet.elasticsearch-lab-pub[count.index].id
  route_table_id = aws_route_table.elasticsearch-lab-public-crt.id

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_subnet.elasticsearch-lab-pub,
    aws_route_table.elasticsearch-lab-public-crt,
  ]
}

