locals {
  ci_cd_ips   = aws_instance.ci_cd.*.private_ip
  monitor_ips = aws_instance.monitor.*.private_ip #monitoring
}
