#################################################################################################
# Autoscale IAM Role
#################################################################################################

resource "aws_iam_role" "Cluster_autoscaler" {
  name = "Cluster-Autoscaler-IAM-Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AutoScalerRole"
        Effect = "Allow"
        Action = ["sts:AssumeRole", "sts:TagSession"]
        Principal = {
          Service = "pods.eks.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "${local.env}"
  }
}

#################################################################################################
# Creating this policy for the IAM Role.
#################################################################################################
resource "aws_iam_policy" "cluster_autoscaler_policy" {
  name = "ClusterAutoscalerPolicy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:DescribeAutoScalingInstances",
          "autoscaling:DescribeLaunchConfigurations",
          "autoscaling:DescribeScalingActivities",
          "autoscaling:DescribeTags",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeLaunchTemplateVersions",
          "eks:DescribeNodegroup"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "autoscaling:SetDesiredCapacity",
          "autoscaling:TerminateInstanceInAutoScalingGroup",
          "autoscaling:UpdateAutoScalingGroup"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:ResourceTag/k8s.io/cluster-autoscaler/enabled" = "true"
          }
        }
      }
    ]
  })
}

#################################################################################################
# Attaching The above IAM Role and Policy together
#################################################################################################

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.Cluster_autoscaler.name
  policy_arn = aws_iam_policy.cluster_autoscaler_policy.arn
}

#################################################################################################
# Attaching this role to the Kubernetes Service account
#################################################################################################
resource "aws_eks_pod_identity_association" "Cluster-autoscaler-pod-association" {
  cluster_name    = aws_eks_cluster.EKS-Master-Node.name
  namespace       = "kube-system"
  service_account = "cluster-autoscaler"
  role_arn        = aws_iam_role.Cluster_autoscaler.arn
}


#################################################################################################
# Helm release Cluster Autoscaler
#################################################################################################

resource "helm_release" "Cluster_autoscaler" {
  name       = "autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  namespace  = "kube-system"
  version    = "9.59.0"


  set = [
    {
      name  = "rbac.serviceAccount.name"
      value = "cluster-autoscaler"
    },
    {
      name  = "autoDiscovery.clusterName"
      value = aws_eks_cluster.EKS-Master-Node.name
    },
    {
      name  = "awsRegion"
      value = "us-east-1"
    }
  ]
  depends_on = [helm_release.metrics_server]
}