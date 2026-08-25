resource "aws_eip" "static_ip" {
  domain = "vpc"
  tags = {
    Name = "${local.env}-nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.static_ip.id
  subnet_id     = aws_subnet.Public_subnet_Zone1.id
  tags = {
    Name = "${local.env}-Nat-Gateway"
  }
  depends_on = [aws_internet_gateway.igw]

}
