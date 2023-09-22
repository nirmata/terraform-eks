output "cluster_name" {
  value = aws_eks_cluster.test-cluster.name
}

output "cluster_id" {
  value = aws_eks_cluster.test-cluster.id
}


output "eks_cluster_vpc_config" {
  value = aws_eks_cluster.test-cluster.vpc_config
}

output "testVPC" {
  value = aws_vpc.testVPC.id
}


output "cluster_endpoint" {
  value = aws_eks_cluster.test-cluster.endpoint
}

output "cluster_ca_certificate" {
  value = aws_eks_cluster.test-cluster.certificate_authority[0].data
}


output "eks_oidc_issuer" {
  value = aws_eks_cluster.test-cluster.identity[0].oidc[0].issuer
}

output "thumbprint_list" {
  value = aws_iam_openid_connect_provider.eks_oidc.thumbprint_list
}

output "aws_region" {
  value = var.aws_region
}

output "aws_profile" {
  value = var.aws_profile
}


output "cluster_security_group" {
  value = aws_eks_cluster.test-cluster.vpc_config[0].cluster_security_group_id
}

output "subnets" {
  value = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]
}


output "vpc_id" {
  value = aws_vpc.testVPC.id
}


output "api_server_endpoint" {
  value = aws_eks_cluster.test-cluster.endpoint
}

output "cluster_ca" {
  value = aws_eks_cluster.test-cluster.certificate_authority[0].data
}


