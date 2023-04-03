resource "aws_instance" "monitor" {
  count                  = var.monitor_count
  ami = var.monitor_linux == "1" ? data.aws_ami.latest_ubuntu.id : data.aws_ami.latest_amazon_linux.id
  user_data = var.monitor_linux == "1" ? file("${path.module}/templates/monitor_user_data.sh") : file("${path.module}/templates/monitor_aws_linux_user_data.sh")
  instance_type          = var.monitor_instance_type
  key_name               = aws_key_pair.internal_key.key_name
  iam_instance_profile   = aws_iam_instance_profile.monitor_profile.id
  subnet_id              = data.terraform_remote_state.network.outputs.private_subnet_ids[count.index]
  vpc_security_group_ids = [data.terraform_remote_state.network.outputs.sg_private]
  root_block_device {
    volume_size = var.monitor_volume_size
    volume_type = "gp2"
    encrypted   = true
  }
  tags = {
    Name = "${var.environment_id}-Monitor-${count.index + 1}"
  }
}