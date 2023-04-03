#__________________________________Frontend
resource "aws_launch_template" "frontend" {
  name = local.frontend_name
  block_device_mappings {
    device_name = var.device_name
    ebs {
      volume_size = var.volume_size
      volume_type = "gp2"
    }
  }
  instance_type = var.instance_type
  key_name      = data.terraform_remote_state.ec2s.outputs.internal_key_name
  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.id
  }
  image_id               = data.aws_ami.latest_amazon_linux.id
  vpc_security_group_ids = [data.terraform_remote_state.network.outputs.sg_private]
  tags = {
    Name        = local.frontend_name
    Environment = var.environment_id
    Purpose     = "frontend"
  }
  user_data = base64encode(data.template_file.frontend_user_data.rendered)
}
#__________________________________Frontend data
data "template_file" "frontend_user_data" {
  template = file("${path.module}/templates/user_data.sh")
  vars = {
    token_registry = var.token_registry
    user_registry  = var.user_registry
    ci_registry    = var.ci_registry
    image          = local.frontend_image
  }
}

#__________________________________Backend
resource "aws_launch_template" "backend" {
  name = local.backend_name
  block_device_mappings {
    device_name = var.device_name
    ebs {
      volume_size = var.volume_size
      volume_type = "gp2"
    }
  }
  instance_type = var.instance_type
  key_name      = data.terraform_remote_state.ec2s.outputs.internal_key_name
  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.id
  }
  image_id               = data.aws_ami.latest_amazon_linux.id
  vpc_security_group_ids = [data.terraform_remote_state.network.outputs.sg_private]
  tags = {
    Name        = local.backend_name
    Environment = var.environment_id
    Purpose     = "backend"
  }
  user_data = base64encode(data.template_file.backend_user_data.rendered)
}
#__________________________________Backend data
data "template_file" "backend_user_data" {
  template = file("${path.module}/templates/user_data.sh")
  vars = {
    token_registry = var.token_registry
    user_registry  = var.user_registry
    ci_registry    = var.ci_registry
    image          = local.backend_image
  }
}

