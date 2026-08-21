# ==========================================================
# EKS CLUSTER
# ==========================================================

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.24.0"

  # ========================================================
  # CLUSTER
  # ========================================================

  cluster_name    = var.cluster_name
  cluster_version = var.kubernetes_version

  cluster_endpoint_public_access = true

  # Do not automatically create an EKS access entry for
  # the IAM role currently running Terraform.
  #
  # Terraform is running from the EC2 instance using:
  # machine1-ecr-push-role
  #
  # GitHubActionsRole is managed explicitly below.
  enable_cluster_creator_admin_permissions = false

  # ========================================================
  # VPC
  # ========================================================

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # ========================================================
  # EKS ADDONS
  # ========================================================

  addons = {
    coredns = {
      most_recent = true
    }

    kube-proxy = {
      most_recent = true
    }

    vpc-cni = {
      most_recent = true
    }

    eks-pod-identity-agent = {
      most_recent = true
    }
  }

  # ========================================================
  # EKS MANAGED NODE GROUP
  # ========================================================

  eks_managed_node_groups = {
    default = {
      name = "${var.cluster_name}-nodegroup"

      instance_types = [var.instance_type]

      min_size     = var.desired_size
      max_size     = var.max_size
      desired_size = var.desired_size

      subnet_ids = module.vpc.private_subnets
    }
  }

  # ========================================================
  # EKS ACCESS ENTRIES
  # ========================================================

  access_entries = {
    github_actions = {
      principal_arn = var.github_actions_role_arn

      policy_associations = {
        github_actions_admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }
}
