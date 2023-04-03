#____________________________________________ Main ALB
resource "aws_lb" "alb" {
  name               = "${var.environment_id}-eschool"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.terraform_remote_state.network.outputs.sg_https]
  subnets            = data.terraform_remote_state.network.outputs.public_subnet_ids
}
#____________________________________________frontend load balancer
resource "aws_lb_listener" "frontend" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.ssl.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_frontend.arn
  }
  depends_on = [aws_acm_certificate_validation.cert]
}
#____________________________________________backend load balancer
resource "aws_lb_listener" "backend" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "8080"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.ssl.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_backend.arn
  }
  depends_on = [aws_acm_certificate_validation.cert]
}

#____________________________________________frontend redirect
resource "aws_lb_listener" "http_frontend" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "redirect"
    redirect {
      protocol         = "HTTPS"
      port             = "443"
      status_code      = "HTTP_301"
    }
  }
  depends_on = [aws_lb_listener.frontend]
}

#____________________________________________backend redirect
#resource "aws_lb_listener" "http_backend" {
#  load_balancer_arn = aws_lb.alb.arn
#  port              = "8080"
#  protocol          = "HTTP"
#  default_action {
#    type             = "redirect"
#    redirect {
#      protocol         = "HTTPS"
#      port             = "8080"
#      status_code      = "HTTP_301"
#    }
#  }
#  depends_on = [aws_lb_listener.backend]
#}
