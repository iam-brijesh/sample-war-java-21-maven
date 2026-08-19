terraform {
  backend "s3" {
    bucket       = "hello-world-eks-terraform-state-022267197315"
    key          = "sample-war/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
