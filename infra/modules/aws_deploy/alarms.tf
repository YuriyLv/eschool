#____________________________________________Frontend
# alarm_up
resource "aws_cloudwatch_metric_alarm" "frontend_cpu_alarm_up" {
  alarm_name          = "${local.frontend_name}-cpu-alarm-up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "3"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "180"
  statistic           = "Average"
  threshold           = "50"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.frontend.name
  }
  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = [aws_autoscaling_policy.frontend_policy_up.arn]
}
# alarm_down
resource "aws_cloudwatch_metric_alarm" "frontend_cpu_alarm_down" {
  alarm_name          = "${local.frontend_name}-cpu-alarm-down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "3"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "180"
  statistic           = "Average"
  threshold           = "15"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.frontend.name
  }
  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = [aws_autoscaling_policy.frontend_policy_down.arn]
}


#____________________________________________Backend
# alarm_up
resource "aws_cloudwatch_metric_alarm" "backend_cpu_alarm_up" {
  alarm_name          = "${local.backend_name}-cpu-alarm-up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "3"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.backend.name
  }
  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = [aws_autoscaling_policy.backend_policy_up.arn]
}
# alarm_down
resource "aws_cloudwatch_metric_alarm" "backend_cpu_alarm_down" {
  alarm_name          = "${local.backend_name}-cpu-alarm-down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "3"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "180"
  statistic           = "Average"
  threshold           = "15"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.backend.name
  }
  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = [aws_autoscaling_policy.backend_policy_down.arn]
}