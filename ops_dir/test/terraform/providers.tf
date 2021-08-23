# Configure backend using AWS S3
# terraform {
#   required_version = ">= 0.12"
#   backend "s3" {
#     bucket = "phil-h-learning-bucket2"
#     key = "state"
#   }
# }


provider "aws" {
    version = ">= 2.28.1"
    region     = var.aws_default_region
    access_key = var.aws_access_key_id
    secret_key = var.aws_secret_access_key
}


# Used to manage local resources such as files
# https://registry.terraform.io/providers/hashicorp/local/latest
provider "local" {
  version = "~> 1.2"
}

# Provides constructs the intentionally do nothing to enable complex behaviors
# https://registry.terraform.io/providers/hashicorp/null/latest
provider "null" {
  version = "~> 2.1"
}

# NO LONGER IN USE, USE INSTEAD; templatefile or CloudInit
# https://registry.terraform.io/providers/hashicorp/template/latest
provider "template" {
  version = "~> 2.1"
}

# Lifecycle management of AWS resources
# https://registry.terraform.io/providers/hashicorp/aws/latest
# provider "aws" {
#   version = ">= 2.28.1"
#   region  = "us-east-2"
# }