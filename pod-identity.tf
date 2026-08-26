resource "aws_eks_addon" "pod-identity-addon" {
  cluster_name                = aws_eks_cluster.EKS-Master-Node.name
  addon_name                  = "eks-pod-identity-agent"
  addon_version               = "v1.4.0-eksbuild.1" #e.g., previous version v1.9.3-eksbuild.3 and the new version is v1.10.1-eksbuild.1
  resolve_conflicts_on_update = "PRESERVE"
}

