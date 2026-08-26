resource "aws_iam_role" "eks-iam-role" {
  name = "${local.env}-${local.eks_name}-eks-cluster"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "eksdemo"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "${local.env}-EKS-IAM-Role"
  }
}

resource "aws_iam_role_policy_attachment" "demo-eks_policy_attachment" {
  role       = aws_iam_role.eks-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
####################################################################################################################
# EKS Cluster - EKS Control plane
####################################################################################################################
resource "aws_eks_cluster" "EKS-Master-Node" {
  name = "${local.env}-eks-controlplane"

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  role_arn = aws_iam_role.eks-iam-role.arn
  version  = local.eks_version

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true

    subnet_ids = [
      aws_subnet.Private_subnet-1_Zone1.id,
      aws_subnet.Private_subnet-2_Zone2.id,
    ]
  }
  depends_on = [
  aws_iam_role_policy_attachment.demo-eks_policy_attachment]
}