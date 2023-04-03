terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.45.0"
    }
  }
  required_version = ">= 1.1.0, <= 1.3.6"
}

module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "5.3.0"

  create_db_instance        = var.create_db_instance
  create_db_parameter_group = var.create_db_parameter_group
  parameters                = var.rds_parameters
  identifier                = "${var.environment_id}-${var.rds_identifier}"
  engine                    = var.engine
  engine_version            = var.engine_version
  instance_class            = var.rds_instance_class
  allocated_storage         = var.rds_storage_size
  storage_type              = var.rds_storage_type


  password    = var.db_password
  db_name     = var.db_name
  username    = var.username
  port        = "3306"

  #create_random_password variable should be set to true if need random pass
  create_random_password = false

  vpc_security_group_ids = [aws_security_group.sg_rds.id]
  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = data.terraform_remote_state.network.outputs.private_subnet_ids

  # DB parameter group
  family = var.family
  # DB option group
  major_engine_version = var.major_engine_version

  # Database Deletion Protection
  deletion_protection = false
  skip_final_snapshot = true


  tags = {
    Name = "${var.environment_name}-${var.rds_identifier}-RDS-insatnce"
  }
  depends_on = [aws_security_group.sg_rds]
}
