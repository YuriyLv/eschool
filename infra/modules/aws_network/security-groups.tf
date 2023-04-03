#____________________________________________Security groups
resource "aws_security_group" "private" {
  vpc_id = aws_vpc.main.id
  dynamic "ingress" {
    for_each = ["22", "80", "8080", "443", "3000", "9090", "9100"] #monitoring
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [aws_vpc.main.cidr_block]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }
  dynamic "egress" {
    for_each = ["53", "80", "443", "3000", "9090", "9100"]
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  tags = {
    Name = "${var.environment_name}-Private-Security-Group"
  }
}

#______________________________security group for ALB public
resource "aws_security_group" "sg_https" {
  vpc_id = aws_vpc.main.id
  dynamic "ingress" {
    for_each = ["8080", "443", "80", "9100"]
    content {
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "${var.environment_name}-Public-Security-Group-for-ALB"
  }
}




