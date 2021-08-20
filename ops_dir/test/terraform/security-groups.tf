# Using the aws provider vpc module
# Provides a security group resource
resource "aws_security_group" "worker_nodes" {
  name_prefix = "all_worker_management"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      local.cidr
    ]
  }
}

resource "aws_security_group" "lb_sg" {
  name        = "${var.app_name}-lb-sg"
  description = "${var.app_name}-lb-sg"
  vpc_id      =  module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    
    cidr_blocks = [
      local.cidr
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // tags = merge(var.tags, { "Name" = "${var.app_name}-lb-sg" })
}