output "bastion_ip" {
  value = aws_instance.bastion.*.public_ip
}
output "ci_cd_ip" {
  value = aws_instance.ci_cd.*.private_ip
}
output "monitor_ip" {
  value = aws_instance.monitor.*.private_ip
}
output "internal_key_name" {
  value = aws_key_pair.internal_key.key_name
}
output "iam_role_ssm_name" {
  value = aws_iam_role.ssm.name
}


