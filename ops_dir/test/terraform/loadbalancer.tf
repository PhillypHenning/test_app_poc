# Define load balancer
resource "aws_lb" "test" {
  name               = "${var.app_name}-lb"
  internal           = false
  load_balancer_type = "network"
  subnets            = ["${aws_subnet.public_a.id}", "${aws_subnet.public_b.id}"]

  
  # security_groups    = [aws_security_group.security_group_example_app.id]
  
  # TODO: I think I will need to use the below code as it's the elastic subnetting
  # subnet_mapping {
  #   subnet_id     = aws_subnet.example1.id
  #   allocation_id = aws_eip.example1.id
  # }

  # subnet_mapping {
  #   subnet_id     = aws_subnet.example2.id
  #   allocation_id = aws_eip.example2.id
  # }

  // Used to stop Terraform from deleting the resource. 
  //enable_deletion_protection = true

  # access_logs {
  #   bucket  = aws_s3_bucket.lb_logs.bucket
  #   prefix  = "test-lb"
  #   enabled = true
  # }
}

# # Define load balancer target group
# resource "aws_lb_target_group" "test" {
#   name        = "${var.app_name}-lb-tg"
#   port        = 80
#   #protocol    = "HTTP"
#   #target_type = "ip"
#   vpc_id      = aws_vpc.vpc_example_app.id
# }

resource "aws_lb_target_group" "test" {

  port        = 3000
  protocol    = "TCP"
  vpc_id      = aws_vpc.vpc_example_app.id

  #stickiness = []

  depends_on = [
    aws_lb.test
  ]

  lifecycle {
    create_before_destroy = true
  }
}


# Network Loadbalancer Listener
# Listener is used to listen to the outside
resource "aws_lb_listener" "test" {
  load_balancer_arn = aws_lb.test.arn
  port              = 80
  protocol          = "TCP"
  //certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"
  //alpn_policy       = "HTTP2Preferred" (optionsal )

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}




