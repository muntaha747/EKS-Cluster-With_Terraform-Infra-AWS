resource "aws_subnet" "Private_subnet-1_Zone1" {
  vpc_id            = aws_vpc.EKS-VPC.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = local.zone1
  tags = {
    "Name"                                                 = "${local.env}-Private-Subnet-1-${local.zone1}"
    "kubernetes.io/role/internal-elb"                      = "1"
    "kubernetes.io/cluster/${local.env}-${local.eks_name}" = "owned"
  }
}


resource "aws_subnet" "Public_subnet-1_Zone1" {
  vpc_id                  = aws_vpc.EKS-VPC.id
  cidr_block              = "10.0.64.0/19"
  availability_zone       = local.zone1
  map_public_ip_on_launch = true
  tags = {
    "Name"                                                 = "${local.env}-Public-Subnet-2-${local.zone1}"
    "kubernetes.io/role/elb"                               = "1"
    "kubernetes.io/cluster/${local.env}-${local.eks_name}" = "owned"
  }
}


resource "aws_subnet" "Private_subnet-2_Zone2" {
  vpc_id            = aws_vpc.EKS-VPC.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = local.zone2
  tags = {
    "Name"                                                 = "${local.env}-Private-Subnet-1-${local.zone2}"
    "kubernetes.io/role/internal-elb"                      = "1"
    "kubernetes.io/cluster/${local.env}-${local.eks_name}" = "owned"
  }
}



resource "aws_subnet" "Public_subnet-2_Zone2" {
  vpc_id                  = aws_vpc.EKS-VPC.id
  cidr_block              = "10.0.96.0/19"
  availability_zone       = local.zone2
  map_public_ip_on_launch = true
  tags = {
    "Name"                                                 = "${local.env}-Private-Subnet-1-${local.zone2}"
    "kubernetes.io/role/elb"                               = "1"
    "kubernetes.io/cluster/${local.env}-${local.eks_name}" = "owned"
  }
}

