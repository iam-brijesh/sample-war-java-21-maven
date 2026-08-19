module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.24.0"

  name               = var.cluster_name
  kubernetes_version = var.kubernetes_version

  endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

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

  eks_managed_node_groups = {
    default = {
      name = "${var.cluster_name}-nodegroup"

      # IMPORTANT
      kubernetes_version = var.kubernetes_version

      iam_role_use_name_prefix = false
      iam_role_name            = "${var.cluster_name}-node-role"

      instance_types = var.instance_types

      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size

      subnet_ids = module.vpc.private_subnets

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

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
