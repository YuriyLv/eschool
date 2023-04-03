provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Environment = var.environment_id
      Role        = "${var.environment_name}-Deploy"
      Purpose     = var.purpose
    }
  }
}

module "versions" {
  source = "../../../modules/aws_versions"
}

module "aws_deploy" {
  source                  = "../../../modules/aws_deploy"
  region                  = var.region
  environment_name        = var.environment_name
  environment_id          = var.environment_id
  state_bucket            = var.state_bucket
  purpose                 = var.purpose
  state_bucket_key        = var.state_bucket_key
  instance_type           = var.instance_type
  volume_size             = var.volume_size
  device_name             = var.device_name
  launch_template_version = var.launch_template_version
  min_size                = var.min_size
  max_size                = var.max_size
  desired_capacity        = var.desired_capacity
  subdomain               = var.subdomain
  token_registry          = var.token_registry
  user_registry           = var.user_registry
  ci_registry             = var.ci_registry
  ci_project_group        = var.ci_project_group
  ci_project_name_fr      = var.ci_project_name_fr
  ci_project_name_back    = var.ci_project_name_back
}



