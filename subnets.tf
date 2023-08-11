resource "aws_subnet" "elasticsearch-lab-pub" {
  count                   = var.subnet_count
  vpc_id                  = aws_vpc.elasticsearch-lab-vpc.id
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.aws_region}${var.az_map[count.index]}"

  tags = {
    Name      = "elasticsearch-lab"
    Terraform = "true"
  }
}