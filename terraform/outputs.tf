output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnets
}

output "private_subnet_ids" {
  value = module.vpc.private_subnets
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

output "node_group_name" {
  value = module.eks.eks_managed_node_groups["default"].node_group_name
}

output "ecr_repository_url" {
  value = aws_ecr_repository.sample_war.repository_url
}
