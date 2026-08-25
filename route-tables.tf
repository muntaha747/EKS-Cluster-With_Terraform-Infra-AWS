resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.EKS-VPC.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "${local.env}-private-route-table"
  }
}


resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.EKS-VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${local.env}-public-route-table"
  }
}
resource "aws_route_table_association" "private_subnet-1_association" {
  subnet_id      = aws_subnet.Private_subnet-1_Zone1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet-2_association" {
  subnet_id      = aws_subnet.Private_subnet-2_Zone2.id
  route_table_id = aws_route_table.private_route_table.id
}


resource "aws_route_table_association" "public_subnet-1_association" {
  subnet_id      = aws_subnet.Public_subnet-1_Zone1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet-2_association" {
  subnet_id      = aws_subnet.Public_subnet-2_Zone2.id
  route_table_id = aws_route_table.public_route_table.id
}