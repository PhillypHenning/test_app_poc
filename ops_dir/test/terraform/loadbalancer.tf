# Define target group attachment
resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = aws_ecs_service.backend_service.id
  port             = 80
}

# Define load balancer
resource "aws_lb" "test" {
  name               = "${var.app_name}-lb"
  internal           = false
  load_balancer_type = "network"

  
  //security_groups    = [aws_security_group.lb_sg.id]
  subnets            = module.vpc.public_subnets

  // Used to stop Terraform from deleting the resource. 
  //enable_deletion_protection = true

  # access_logs {
  #   bucket  = aws_s3_bucket.lb_logs.bucket
  #   prefix  = "test-lb"
  #   enabled = true
  # }
}

# Define load balancer target group
resource "aws_lb_target_group" "test" {
  name        = "${var.app_name}-lb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id
}