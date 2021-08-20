# Assumption;
# You want to create an EKS cluster and an autoscaling group of workers for the cluster.
# You want these resources to exist within security groups that allow communication and coordination. These can be user provided or created within the module.
# You've created a Virtual Private Cloud (VPC) and subnets where you intend to put the EKS resources. The VPC satisfies EKS requirements.

# Local variables
locals {
  cluster_name = "${var.app_name}-eks"
}

# Using the aws provider eks module
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = local.cluster_name
  cluster_version = "1.17"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id
  manage_aws_auth = false
  node_groups = {
    test = {
      instance_type = "t3.small"
      name = "${var.app_name}-nodegroup"
    }
  }
}