output "bastion_ip" {
  value = module.aws_ec2s.bastion_ip
}
output "ci_cd_ip" {
  value = module.aws_ec2s.ci_cd_ip
}
output "monitor_ip" {
  value = module.aws_ec2s.monitor_ip
}
output "internal_key_name" {
  value = module.aws_ec2s.internal_key_name
}
output "iam_role_ssm_name" {
  value = module.aws_ec2s.iam_role_ssm_name
}