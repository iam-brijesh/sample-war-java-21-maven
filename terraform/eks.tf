module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.24.0"

  # ==========================================================
  # EKS CLUSTER
  # ==========================================================

  name               = var.cluster_name
  kubernetes_version = var.kubernetes_version

  # ==========================================================
  # EXISTING VPC
  # ==========================================================

  vpc_id     = data.aws_vpc.existing.id
  subnet_ids = data.aws_subnets.private.ids

  # ==========================================================
  # EKS API ENDPOINT
  # ==========================================================

  endpoint_public_access  = true
  endpoint_private_access = true

  # ==========================================================
  # EXISTING CLUSTER IAM ROLE
  # ==========================================================

  create_iam_role = false

  iam_role_arn = var.cluster_iam_role_arn

  # ==========================================================
  # EXISTING KMS KEY
  # ==========================================================

  create_kms_key = false

  encryption_config = {
    provider_key_arn = var.kms_key_arn

    resources = [
      "secrets"
    ]
  }

  # ==========================================================
  # CLUSTER CREATOR ADMIN
  # ==========================================================

  enable_cluster_creator_admin_permissions = true

  # ==========================================================
  # GITHUB ACTIONS ACCESS
  # ==========================================================

  access_entries = {
    github_actions = {
      principal_arn = var.github_actions_role_arn

      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  # ==========================================================
  # EKS ADDONS
  # ==========================================================

  addons = {
    vpc-cni = {
      most_recent = true
    }

    coredns = {
      most_recent = true
    }

    kube-proxy = {
      most_recent = true
    }

    eks-pod-identity-agent = {
      most_recent = true
    }
  }

  # ==========================================================
  # MANAGED NODE GROUP
  # ==========================================================

  eks_managed_node_groups = {
    default = {

      name = "${var.cluster_name}-nodegroup"

      kubernetes_version = var.kubernetes_version

      # ------------------------------------------------------
      # NODE IAM ROLE
      # ------------------------------------------------------

      create_iam_role          = true
      iam_role_use_name_prefix = false
      iam_role_name            = "${var.cluster_name}-node-role"

      # ------------------------------------------------------
      # NODE INSTANCE
      # ------------------------------------------------------

      instance_types = var.instance_types

      capacity_type = "ON_DEMAND"

      # ------------------------------------------------------
      # NODE SCALING
      # ------------------------------------------------------

      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size

      # ------------------------------------------------------
      # PRIVATE SUBNETS
      # ------------------------------------------------------

      subnet_ids = data.aws_subnets.private.ids

      # ------------------------------------------------------
      # NODE LABELS
      # ------------------------------------------------------

      labels = {
        Environment = "dev"
      }

      # ------------------------------------------------------
      # NODE TAGS
      # ------------------------------------------------------

      tags = {
        Environment = "dev"
        Terraform   = "true"
      }
    }
  }

  # ==========================================================
  # CLUSTER TAGS
  # ==========================================================

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
