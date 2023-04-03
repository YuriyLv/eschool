#____________________________________________Role for Bastion
resource "aws_iam_role" "ssm" {
  name               = "${var.environment_id}-ssm"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "ec2_for_ssm" {
  role       = aws_iam_role.ssm.name
  policy_arn = data.aws_iam_policy.ec2_for_ssm.arn
}
resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ssm.name
  policy_arn = data.aws_iam_policy.ssm.arn
}
#____________________________________________Bastion Instance Profile
resource "aws_iam_instance_profile" "bastion_profile" {
  name = "${var.environment_id}-Bastion"
  role = aws_iam_role.ssm.name
}

#____________________________________________Role for CI/CD
resource "aws_iam_role" "ci_cd" {
  name               = "${var.environment_id}-CI-CD"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "ci_cd_ec2_for_ssm" {
  role       = aws_iam_role.ci_cd.name
  policy_arn = data.aws_iam_policy.ec2_for_ssm.arn
}
resource "aws_iam_role_policy_attachment" "ci_cd_ssm" {
  role       = aws_iam_role.ci_cd.name
  policy_arn = data.aws_iam_policy.ssm.arn
}
resource "aws_iam_role_policy_attachment" "ci_cd_ec2_read_only" {
  role       = aws_iam_role.ci_cd.name
  policy_arn = data.aws_iam_policy.ec2_read_only.arn
}
#____________________________________________CI/CD Instance Profile
resource "aws_iam_instance_profile" "ci_cd_profile" {
  name = "${var.environment_id}-CI-CD"
  role = aws_iam_role.ci_cd.name
}

#____________________________________________Role for Monitor
resource "aws_iam_role" "monitor" {
  name               = "${var.environment_id}-Monitor"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "monitor_ec2_for_ssm" {
  role       = aws_iam_role.monitor.name
  policy_arn = data.aws_iam_policy.ec2_for_ssm.arn
}
resource "aws_iam_role_policy_attachment" "monitor_ssm" {
  role       = aws_iam_role.monitor.name
  policy_arn = data.aws_iam_policy.ssm.arn
}
resource "aws_iam_role_policy_attachment" "monitor_ec2_read_only" {
  role       = aws_iam_role.monitor.name
  policy_arn = data.aws_iam_policy.ec2_read_only.arn
}

#____________________________________________Policy for Monitor
data "aws_iam_policy_document" "monitor_policy" {
  statement {
    effect    = "Allow"
    actions = [
      "ec2:DescribeInstances",
      "ec2:DescribeTags",
      "ec2:DescribeRegions",
      "tag:GetTagValues",
      "tag:GetTagKeys"
    ]
    resources = ["*"]
  }
}
resource "aws_iam_policy" "monitor_policy" {
  name        = "monitor_policy"
  policy      = data.aws_iam_policy_document.monitor_policy.json
}
#____________________________________________Policy v2 for Monitor
resource "aws_iam_policy" "prometheus_policy" {
  name        = "prometheus_policy"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowPrometheusAccess"
        Effect    = "Allow"
        Action    = [
          "ec2:DescribeInstances",
          "ec2:DescribeTags"
        ]
        Resource  = "*"
        Condition = {
          StringEquals = {
            "ec2:VpcId" = "${data.terraform_remote_state.network.outputs.vpc_id}"
          }
        }
      }
    ]
  })
}
#____________________________________________Attach new prometheus_policy to monitor role
resource "aws_iam_role_policy_attachment" "prometheus_role_policy_attachment" {
  policy_arn = aws_iam_policy.prometheus_policy.arn
  role       = aws_iam_role.monitor.name
}
#____________________________________________Attach new monitor_policy to monitor role
resource "aws_iam_policy_attachment" "monitor_ec2_describe" {
  name       = "${var.environment_id}-Monitor"
  roles       = [aws_iam_role.monitor.name]
  policy_arn = aws_iam_policy.monitor_policy.arn
}




















#____________________________________________Monitor Instance Profile
resource "aws_iam_instance_profile" "monitor_profile" {
  name = "${var.environment_id}-Monitor"
  role = aws_iam_role.monitor.name
}
