#__________________________________FrontendProfile for frontend & backend ec2 instances
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.environment_id}-ec2-ssm"
  role = data.terraform_remote_state.ec2s.outputs.iam_role_ssm_name
}