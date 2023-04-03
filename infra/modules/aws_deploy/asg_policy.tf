#__________________________________Frontend
# Frontend down policy
resource "aws_autoscaling_policy" "frontend_policy_down" {
  name                   = "${local.frontend_name}-policy-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.frontend.name
}
# Frontend up policy
resource "aws_autoscaling_policy" "frontend_policy_up" {
  name                   = "${local.frontend_name}-policy-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.frontend.name
}

#__________________________________Backend
# Backend down policy
resource "aws_autoscaling_policy" "backend_policy_down" {
  name                   = "${local.backend_name}-policy-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.backend.name
}
# Backend up policy
resource "aws_autoscaling_policy" "backend_policy_up" {
  name                   = "${local.backend_name}-policy-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.backend.name
}