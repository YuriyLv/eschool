#__________________________________Frontend target group
resource "aws_alb_target_group" "target_frontend" {
  name        = local.frontend_name
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = "2"
    path                = "/"
    interval            = 5
    matcher             = "200,301,401"
  }
}

#__________________________________Backend target group
resource "aws_alb_target_group" "target_backend" {
  name        = local.backend_name
  port        = 8080
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = "2"
    path                = "/ui/login"
    interval            = 5
    matcher             = "200,301,401"
  }
}