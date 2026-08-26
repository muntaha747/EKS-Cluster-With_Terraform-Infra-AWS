resource "aws_iam_role" "nodes-pool" {
  name = "eks-node-group-iam-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "sts:AssumeRole"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]

  })
}

resource "aws_iam_role_policy_attachment" "demo-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes-pool.name
}

resource "aws_iam_role_policy_attachment" "demo-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes-pool.name
}

resource "aws_iam_role_policy_attachment" "demo-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes-pool.name
}

####################################################################################################################
# EKS Cluster - Worker Nodes.
####################################################################################################################

resource "aws_eks_node_group" "worker_nodes" {
  cluster_name    = aws_eks_cluster.EKS-Master-Node.name
  version         = local.eks_version
  node_group_name = "EKS-Worker-Nodes"
  node_role_arn   = aws_iam_role.nodes-pool.arn
  subnet_ids      = [aws_subnet.Private_subnet-1_Zone1.id, aws_subnet.Private_subnet-2_Zone2.id]
  capacity_type   = "ON_DEMAND"
  instance_types  = ["t3.large"]
  scaling_config {
    desired_size = 2
    max_size     = 10
    min_size     = 0
  }
  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "general" #We will use this in pod affinity and node selectors
  }
  depends_on = [
    aws_iam_role_policy_attachment.demo-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.demo-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.demo-AmazonEC2ContainerRegistryReadOnly,
  ]

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size] # This do is it will kubectl scale --replicas=4 or use aws console to increase the sizre of the cluster. When you will do this you dont want terraform at the plan to see the difference. You want terraform to ignore it.action_trigger {

  }
}