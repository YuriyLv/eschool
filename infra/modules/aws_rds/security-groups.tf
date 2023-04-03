resource "aws_security_group" "sg_rds" {
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.network.outputs.vpc_cidr]
  }
  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.network.outputs.vpc_cidr]
  }
  tags = {
    Name = "${var.environment_name}-SG-for-RDS"
  }
}

