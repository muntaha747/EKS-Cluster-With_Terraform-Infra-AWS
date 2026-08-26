###########################################################
# IAM User
###########################################################
resource "aws_iam_user" "DevOps_Engineer" {
  name = "DevOps_Engineer"
  tags = {
    Name = "${local.iam_user}_Iam_User"
  }
}

###########################################################
# Creating Inline Policy for the IAM User
###########################################################

resource "aws_iam_policy" "DevOps_Engineer_policy" {
  name = "DevOpsEngineerPolicy"


  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "DevOpsEngineerPolicy",
        "Effect" : "Allow",
        "Action" : [
          "eks:DescribeCluster",
          "eks:ListClusters"
        ], #This policy arn which we created by specific format --> ARN should follow the following format: arn:aws:qapps:${Region}:${Account}:${ResourceType}:${ResourcePath}.
        "Resource" : "arn:aws:eks:us-east-1:747482682170:cluster/staging-eks-controlplane"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "attaching_policy_to_user" {
  user       = aws_iam_user.DevOps_Engineer.name
  policy_arn = aws_iam_policy.DevOps_Engineer_policy.arn
}


###########################################################
# AWS EKS Entry point to connect with the k8s cluster
###########################################################

resource "aws_eks_access_entry" "user_binding_with_K8s_group" {
  cluster_name      = aws_eks_cluster.EKS-Master-Node.name
  principal_arn     = aws_iam_user.DevOps_Engineer.arn
  kubernetes_groups = ["viewer-group"]
  type              = "STANDARD"
}

