resource "aws_instance" "ci_cd" {
  count                  = var.ci_cd_count
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.ci_cd_instance_type
  key_name               = aws_key_pair.internal_key.key_name
  iam_instance_profile   = aws_iam_instance_profile.ci_cd_profile.id
  subnet_id              = data.terraform_remote_state.network.outputs.private_subnet_ids[count.index]
  vpc_security_group_ids = [data.terraform_remote_state.network.outputs.sg_private]
  user_data              = file("${path.module}/templates/user_data.sh")
  root_block_device {
    volume_size = var.ci_cd_volume_size
    volume_type = "gp2"
    encrypted   = true
  }
  tags = {
    Name = "${var.environment_id}-CI/CD-${count.index + 1}"
  }
}
resource "aws_key_pair" "internal_key" {
  key_name   = var.internal_key_name
  public_key = file(var.internal_key_path)
}

