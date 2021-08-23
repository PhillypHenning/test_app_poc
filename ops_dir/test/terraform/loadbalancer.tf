# Define load balancer
resource "aws_lb" "test" {
  name               = "${var.app_name}-lb"
  internal           = false
  load_balancer_type = "network"
  subnets            = ["${aws_subnet.public_a.id}", "${aws_subnet.public_b.id}"]
}

resource "aws_lb_target_group" "test" {

  port        = 3000
  protocol    = "TCP"
  vpc_id      = aws_vpc.vpc_example_app.id
  target_type = "ip"

  #stickiness = []

  depends_on = [
    aws_lb.test
  ]

  lifecycle {
    create_before_destroy = true
  }

  //health_check {
    // enabled = false <-- awsvpc doesn't allow Health checks to be disabled
  //}
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




