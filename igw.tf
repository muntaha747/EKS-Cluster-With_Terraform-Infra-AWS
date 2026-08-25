resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.EKS-VPC.id
  tags = {
    Name = "${local.env}-igw"
  }
}
