# Creates local variables
locals {
  cidr = "10.0.0.0/16"
}

# aws_availability_zones is from aws core provider
# The Availability Zones data source allows access to the list of AWS Availability Zones which can be accessed by an AWS account within the region configured in the provider.
data "aws_availability_zones" "available" {}

# Using the aws provider vpc module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.6.0"

  
  name                 = "bitops-philh-vpc"
  cidr                 = local.cidr
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = [cidrsubnet(local.cidr, 8, 1), cidrsubnet(local.cidr, 8, 2), cidrsubnet(local.cidr, 8, 3)]
  public_subnets       = [cidrsubnet(local.cidr, 8, 4), cidrsubnet(local.cidr, 8, 5), cidrsubnet(local.cidr, 8, 6)]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}