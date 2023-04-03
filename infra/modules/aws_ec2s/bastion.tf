resource "aws_instance" "bastion" {
  count                       = var.bastion_count
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = var.bastion_instance_type
  subnet_id                   = data.terraform_remote_state.network.outputs.public_subnet_ids[count.index]
  key_name                    = var.bastion_key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg_bastion.id]
  iam_instance_profile        = aws_iam_instance_profile.bastion_profile.id
  user_data                   = file("${path.module}/templates/user_data.sh")
  root_block_device {
    volume_size = var.bastion_volume_size
    volume_type = "gp2"
    encrypted   = true
  }
  tags = {
    Name = "${var.environment_id}-Bastion-${count.index + 1}"
  }
}
