resource "aws_security_group" "sg_bastion" {
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [data.terraform_remote_state.network.outputs.vpc_cidr]
  }
  dynamic "egress" {
    for_each = [var.my_ip]
    content {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [egress.value]
    }
  }
  dynamic "egress" {
    for_each = ["53", "443"]
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  tags = {
    Name = "${var.environment_name}-SG-for-Bastion"
  }
}

