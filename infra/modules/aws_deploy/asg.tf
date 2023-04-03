#__________________________________Frontend
resource "aws_autoscaling_group" "frontend" {
  name = local.frontend_name
  launch_template {
    id      = aws_launch_template.frontend.id
    version = var.launch_template_version
  }
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = data.terraform_remote_state.network.outputs.private_subnet_ids
  lifecycle {
    ignore_changes        = [load_balancers, target_group_arns]
    create_before_destroy = true
  }
  dynamic "tag" {
    for_each = {
      Name        = local.frontend_name
      Environment = var.environment_id
    }
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_target" {
  autoscaling_group_name = aws_autoscaling_group.frontend.id
  lb_target_group_arn    = aws_alb_target_group.target_frontend.arn
  depends_on             = [aws_autoscaling_group.frontend]
}

#__________________________________Backend
resource "aws_autoscaling_group" "backend" {
  name = local.backend_name
  launch_template {
    id      = aws_launch_template.backend.id
    version = var.launch_template_version
  }
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = data.terraform_remote_state.network.outputs.private_subnet_ids
  lifecycle {
    ignore_changes        = [load_balancers, target_group_arns]
    create_before_destroy = true
  }
  dynamic "tag" {
    for_each = {
      Name        = local.backend_name
      Environment = var.environment_id
    }
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_target_backend" {
  autoscaling_group_name = aws_autoscaling_group.backend.id
  lb_target_group_arn    = aws_alb_target_group.target_backend.arn
  depends_on             = [aws_autoscaling_group.backend]
}