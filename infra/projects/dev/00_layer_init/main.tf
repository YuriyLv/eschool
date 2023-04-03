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

module "versions" {
  source     = "../../../modules/aws_versions"
}

module "aws_dynamo_db" {
  source     = "../../../modules/aws_dynamo_db"
  table_name = var.table_name
}

module "aws-s3" {
  source           = "../../../modules/aws_s3"
  region           = var.region
  environment_name = var.environment_name
  environment_id   = var.environment_id
  state_bucket     = var.state_bucket
  purpose          = var.purpose
  state_bucket_key = var.state_bucket_key
}
