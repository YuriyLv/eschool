provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Environment = var.environment_id
      Role        = "${var.environment_name}-State-bucket"
      Purpose     = var.purpose
    }
  }
}

module "aws_rds" {
  source                    = "../../../modules/aws_rds"
  region                    = var.region
  environment_name          = var.environment_name
  environment_id            = var.environment_id
  state_bucket              = var.state_bucket
  purpose                   = var.purpose
  state_bucket_key          = var.state_bucket_key
  create_db_instance        = var.create_db_instance
  create_db_parameter_group = var.create_db_parameter_group
  rds_identifier            = var.rds_identifier
  rds_instance_class        = var.rds_instance_class
  engine                    = var.engine
  family                    = var.family
  major_engine_version      = var.major_engine_version
  rds_storage_size          = var.rds_storage_size
  rds_storage_type          = var.rds_storage_type
  engine_version            = var.engine_version
  db_name                   = var.db_name
  username                  = var.username
  db_password               = var.db_password
  rds_parameters            = var.rds_parameters
}
