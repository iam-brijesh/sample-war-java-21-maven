data "aws_vpc" "existing" {
  id = "vpc-0a2677f7e7eddad6c"
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing.id]
  }

  filter {
    name   = "tag:Name"
    values = ["${var.cluster_name}-vpc-private-*"]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing.id]
  }

  filter {
    name   = "tag:Name"
    values = ["${var.cluster_name}-vpc-public-*"]
  }
}
