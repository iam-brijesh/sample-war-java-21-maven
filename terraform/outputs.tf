output "vpc_id" {
  value = data.aws_vpc.existing.id
}

output "public_subnet_ids" {
  value = data.aws_subnets.public.ids
}

output "private_subnet_ids" {
  value = data.aws_subnets.private.ids
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_arn" {
  value = module.eks.cluster_arn
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "node_group_id" {
  description = "EKS managed node group ID"
  value       = module.eks.eks_managed_node_groups["default"].node_group_id
}

output "ecr_repository_url" {
  value = aws_ecr_repository.sample_war.repository_url
}
