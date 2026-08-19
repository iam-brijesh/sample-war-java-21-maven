module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.24.0"

  name               = var.cluster_name
  kubernetes_version = var.kubernetes_version

  # ==========================================================
  # EXISTING EKS CLUSTER IAM ROLE
  # ==========================================================

  create_iam_role = false

  iam_role_arn = "arn:aws:iam::022267197315:role/hello-world-eks-cluster-de4aa8e9493ee2624eff249f7a"

  # ==========================================================
  # EXISTING VPC
  # ==========================================================

  vpc_id     = data.aws_vpc.existing.id
  subnet_ids = data.aws_subnets.private.ids

  # ==========================================================
  # EKS ENDPOINT
  # ==========================================================

  endpoint_public_access  = true
  endpoint_private_access = true

  # ==========================================================
  # EXISTING CLUSTER SECURITY GROUP
  #
  # Existing additional SG attached to cluster:
  # sg-0db6c184778c168a9
  #
  # Primary EKS SG:
  # sg-0ed880a3fd601ead3
  # ==========================================================

  create_security_group = false

  vpc_security_group_ids = [
    "sg-0db6c184778c168a9"
  ]

  # ==========================================================
  # EXISTING KMS KEY
  # ==========================================================

  create_kms_key = false

  encryption_config = {
    provider_key_arn = "arn:aws:kms:ap-south-1:022267197315:key/8a71b8ff-31d0-4a28-9f54-7ad496f52851"

    resources = [
      "secrets"
    ]
  }

  # ==========================================================
  # ACCESS MANAGEMENT
  # ==========================================================

  enable_cluster_creator_admin_permissions = true

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

      iam_role_use_name_prefix = false
      iam_role_name             = "${var.cluster_name}-node-role"

      instance_types = var.instance_types

      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size

      subnet_ids = data.aws_subnets.private.ids

      capacity_type = "ON_DEMAND"

      labels = {
        Environment = "dev"
      }

      tags = {
        Environment = "dev"
        Terraform   = "true"
      }
    }
  }

  # ==========================================================
  # TAGS
  # ==========================================================

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
