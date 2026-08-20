# ==========================================================
# AWS
# ==========================================================

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

# ==========================================================
# EKS CLUSTER
# ==========================================================

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "hello-world-eks"
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.36"
}

# ==========================================================
# EXISTING EKS CLUSTER IAM ROLE
# ==========================================================

variable "cluster_iam_role_arn" {
  description = "Existing IAM role ARN used by the EKS control plane"
  type        = string

  default = "arn:aws:iam::022267197315:role/hello-world-eks-cluster-de4aa8e9493ee2624eff249f7a"
}

# ==========================================================
# EXISTING KMS KEY
# ==========================================================

variable "kms_key_arn" {
  description = "Existing KMS key ARN used for EKS secrets encryption"
  type        = string

  default = "arn:aws:kms:ap-south-1:022267197315:key/8a71b8ff-31d0-4a28-9f54-7ad496f52851"
}

# ==========================================================
# VPC
# ==========================================================

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

# ==========================================================
# EKS NODE GROUP
# ==========================================================

variable "instance_types" {
  description = "EKS managed node group instance types"
  type        = list(string)
  default     = ["t3.small"]
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 2
}

variable "desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 1
}

# ==========================================================
# GITHUB ACTIONS
# ==========================================================

variable "github_actions_role_arn" {
  description = "IAM role ARN used by GitHub Actions"
  type        = string

  default = "arn:aws:iam::022267197315:role/GitHubActionsRole"
}
