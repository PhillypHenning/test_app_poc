resource "aws_lb" "test" {
  name               = "${var.app_name}-lb"
  internal           = false
  load_balancer_type = "application"
  
  // Issue 1
  security_groups    = [aws_security_group.lb_sg.id]
  // Issue 2
  subnets            = module.vpc.public_subnets

  // Used to stop Terraform from deleting the resource. 
  //enable_deletion_protection = true

  # access_logs {
  #   bucket  = aws_s3_bucket.lb_logs.bucket
  #   prefix  = "test-lb"
  #   enabled = true
  # }
}


resource "aws_lb_target_group" "test" {
  name     = "${var.app_name}-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
}