#We are installing the standard kubernetes metrics server with the helm charts.

resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  namespace  = "kube-system"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  version    = "3.13.1"
  chart      = "metrics-server"
  values     = [file("${path.module}/values/metrics-server.yaml")]
  depends_on = [aws_eks_node_group.worker_nodes]
}
