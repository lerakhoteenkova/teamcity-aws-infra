output "cluster_name" {
  value = aws_eks_cluster.eks-dev-0
}

output "cluster_endpoint" {
  value = aws_eks_cluster.eks-dev-0.endpoint
}

output "cluster_ca_certificate" {
  value = aws_eks_cluster.eks-dev-0.certificate_authority[0].data
}