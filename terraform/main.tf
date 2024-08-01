locals {
  name_prefix  = var.name=="" ? "" : "${var.name}-"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.9.0"

  name = "${local.name_prefix}vpc"

  azs  = slice(data.aws_availability_zones.available.names, 0, 3)

  cidr            = "10.0.0.0/16"
  private_subnets = ["10.0.16.0/20", "10.0.32.0/20"]
  public_subnets  = ["10.0.128.0/20", "10.0.144.0/20"]

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
    "Type"                   = "public"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
    "Type"                            = "private"
  }

  enable_nat_gateway   = true
  single_nat_gateway   = true
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.20.0"

  cluster_name    = "${local.name_prefix}monolith"
  cluster_version = "1.30"

  cluster_addons = {
    coredns                = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    group = {
      name = "node-group-1"
      ami_type = "AL2_x86_64"

      instance_types = ["t3.small"]

      min_size     = 3
      max_size     = 8
      desired_size = 5
    }
  }
}
