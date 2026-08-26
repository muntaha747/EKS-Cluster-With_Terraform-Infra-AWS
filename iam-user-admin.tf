data "aws_caller_identity" "current" {}

#################################################
# AWS IAM Role to be created instead of IAM User
#################################################

resource "aws_iam_role" "eks_admin_role" {
  name = "eks_admin_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "EKSAdminRole"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}

#################################################
# AWS IAM policy will be created for the role
#################################################
resource "aws_iam_policy" "role_policy" {
  name = "role_policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "eksrolepolicy",
        "Effect" : "Allow",
        "Action" : "eks:*",
        "Resource" : "*"
      },
      {
        "Sid" : "passRoleToEks",
        "Effect" : "Allow",
        "Action" : "iam:PassRole",
        "Resource" : "*",
        "Condition" : {
          "StringEquals" : {
            "iam:PassedToService" : "eks.amazonaws.com"
          }
        }
      }
    ]
  })
}

#################################################
# AWS IAM role policy is attached
#################################################
resource "aws_iam_role_policy_attachment" "IAM_Role_Policy_attachment" {
  role       = aws_iam_role.eks_admin_role.name
  policy_arn = aws_iam_policy.role_policy.arn
}

#############################################################
# We will create another IAM user and let it assume this role
#############################################################

resource "aws_iam_user" "DevOps_manager" {
  name = "DevOps_Manager"
}

################################################################
# We will create another IAM policy for the DevOps manager user
################################################################

resource "aws_iam_policy" "policy" {
  name = "AmazonEKSAssumeAdminPolicy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Resource = aws_iam_role.eks_admin_role.arn
      },
    ]
  })
}

resource "aws_iam_user_policy_attachment" "iam_user_manager_policy_attachment" {
  user       = aws_iam_user.DevOps_manager.name
  policy_arn = aws_iam_policy.policy.arn
}

#############################################################
# Map the role to a Kubernetes RBAC group via EKS access entry
#############################################################

resource "aws_eks_access_entry" "admin-access-point" {
  cluster_name      = aws_eks_cluster.EKS-Master-Node.name
  principal_arn     = aws_iam_role.eks_admin_role.arn
  kubernetes_groups = ["my-admin"]
  type              = "STANDARD"
}