data "tls_certificate" "example" {
  url = aws_eks_cluster.test-cluster.identity[0].oidc[0].issuer
}