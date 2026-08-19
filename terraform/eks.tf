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
  # EXISTING EKS CLUSTER IAM ROLE
  #
  # Existing AWS cluster uses:
  # hello-world-eks-cluster-de4aa8e9493ee2624eff249f7a
  # ==========================================================

  create_iam_role = false

  iam_role_arn = "arn:aws:iam::022267197315:role/hello-world-eks-cluster-de4aa8e9493ee2624eff249f7a"

  # ==========================================================
  # EXISTING KMS KEY
  #
  # Existing AWS cluster uses:
  # 8a71b8ff-31d0-4a28-9f54-7ad496f52851
  # ==========================================================

  create_kms_key = false

  encryption_config = {
    provider_key_arn = "arn:aws:kms:ap-south-1:022267197315:key/8a71b8ff-31d0-4a28-9f54-7ad496f52851"

    resources = [
      "secrets"
    ]
  }

  # ==========================================================
  # CLUSTER CREATOR ADMIN
  # ==========================================================

  enable_cluster_creator_admin_permissions = true

  # ==========================================================
  # EKS ACCESS ENTRIES
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

  # ==========================================================
  # MANAGED NODE GROUP
  # ==========================================================

  eks_managed_node_groups = {
    default = {
      name = "${var.cluster_name}-nodegroup"

      kubernetes_version = var.kubernetes_version

      # ------------------------------------------------------
      # Existing node IAM role
      # ------------------------------------------------------

      iam_role_use_name_prefix = false
      iam_role_name             = "${var.cluster_name}-node-role"

      # ------------------------------------------------------
      # Instance configuration
      # ------------------------------------------------------

      instance_types = var.instance_types

      capacity_type = "ON_DEMAND"

      # ------------------------------------------------------
      # Scaling
      # ------------------------------------------------------

      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size

      # ------------------------------------------------------
      # Existing private subnets
      # ------------------------------------------------------

      subnet_ids = data.aws_subnets.private.ids

      # ------------------------------------------------------
      # Kubernetes labels
      # ------------------------------------------------------

      labels = {
        Environment = "dev"
      }

      # ------------------------------------------------------
      # Tags
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
