output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_version" {
  description = "EKS Kubernetes version"
  value       = var.kubernetes_version
}

output "vpc_id" {
  description = "Existing VPC ID"
  value       = data.aws_vpc.existing.id
}

output "public_subnet_ids" {
  description = "Existing public subnet IDs"
  value       = data.aws_subnets.public.ids
}

output "private_subnet_ids" {
  description = "Existing private subnet IDs"
  value       = data.aws_subnets.private.ids
}

output "node_group_name" {
  description = "EKS managed node group name"
  value       = module.eks.eks_managed_node_groups["default"].node_group_name
}

output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = aws_ecr_repository.sample_war.repository_url
}
