variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "hello-world-eks"
}

variable "kubernetes_version" {
  description = "EKS Kubernetes version"
  type        = string
  default     = "1.36"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "instance_types" {
  description = "EKS worker node instance types"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "desired_size" {
  description = "Desired number of EKS worker nodes"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum number of EKS worker nodes"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of EKS worker nodes"
  type        = number
  default     = 3
}

variable "github_actions_role_arn" {
  description = "IAM role used by GitHub Actions"
  type        = string
  default     = "arn:aws:iam::022267197315:role/GitHubActionsRole"
}
