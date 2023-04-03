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

module "aws_versions" {
  source = "../../../modules/aws_versions"
}

module "aws_ec2s" {
  source                           = "../../../modules/aws_ec2s"
  region                           = var.region
  environment_name                 = var.environment_name
  environment_id                   = var.environment_id
  state_bucket                     = var.state_bucket
  purpose                          = var.purpose
  state_bucket_key                 = var.state_bucket_key
  bastion_count                    = var.bastion_count
  bastion_instance_type            = var.bastion_instance_type
  bastion_key_name                 = var.bastion_key_name
  my_ip                            = var.my_ip
  bastion_volume_size              = var.bastion_volume_size
  bastion_user                     = var.bastion_user
  bastion_key                      = var.bastion_key
  source_bastion_internal_key      = var.source_bastion_internal_key
  destination_bastion_internal_key = var.destination_bastion_internal_key
  ci_cd_count                      = var.ci_cd_count
  ci_cd_instance_type              = var.ci_cd_instance_type
  internal_key_name                = var.internal_key_name
  internal_key_path                = var.internal_key_path
  ci_cd_volume_size                = var.ci_cd_volume_size
  gitlab_url                       = var.gitlab_url
  registration_token               = var.registration_token
  runner_tags_list                 = var.runner_tags_list
  runner_executor                  = var.runner_executor
  monitor_count                    = var.monitor_count
  monitor_instance_type            = var.monitor_instance_type
  monitor_volume_size              = var.monitor_volume_size
  destination_monitor_internal_key = var.destination_monitor_internal_key
  monitor_user                     = var.monitor_user
  monitor_linux                    = var.monitor_linux
}