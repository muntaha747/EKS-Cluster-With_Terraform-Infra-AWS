data "aws_eks_cluster" "EKS-Master-Node" {
  name = aws_eks_cluster.EKS-Master-Node.name
}

data "aws_eks_cluster_auth" "EKS-Master-Node" {
  name = aws_eks_cluster.EKS-Master-Node.name
}

provider "helm" {
  kubernetes = {
    host                   = data.aws_eks_cluster.EKS-Master-Node.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.EKS-Master-Node.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.EKS-Master-Node.token #This is short lived token if you want the long lived tokens than you have to use the exec instead of token. So what it will does it that the terraform will request another fresh token once it is expired.
    #     exec = {
    #       api_version = "client.authentication.k8s.io/v1beta1"
    #       command     = "aws"
    #       args = [
    #         "eks",
    #         "get-token",
    #         "--cluster-name",
    #         data.aws_eks_cluster.EKS-Master-Node.name,
    #       ]
    #     }
    #   }
    # }
  }
}