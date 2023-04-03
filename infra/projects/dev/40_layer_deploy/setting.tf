#____________________________________________backend
terraform {
  backend "s3" {
    region         = "eu-west-1"
    bucket         = "netw-bas-cicd-rds-tests"
    key            = "deploy/terraform.tfstate"
    dynamodb_table = "netw-bas-cicd-rds-tests"
  }
}
#____________________________________________State
variable "region" {
  default = "eu-west-1"
}
variable "environment_name" {
  default = "develop"
}
variable "environment_id" {
  default = "dev"
}
variable "state_bucket" {
  default = "netw-bas-cicd-rds-tests"
}
variable "purpose" {
  default = "developing"
}
variable "state_bucket_key" {
  default = "deploy/terraform.tfstate"
}
variable "table_name" {
  default = "netw-bas-cicd-rds-tests"
}
#____________________________________________asg
variable "instance_type" {
  default = "t3.small"
}
variable "volume_size" {
  default = 12
}
variable "device_name" {
  default = "/dev/sda1"
}
variable "launch_template_version" {
  default = "$Latest"
}
variable "min_size" {
  default = 1
}
variable "max_size" {
  default = 2
}
variable "desired_capacity" {
  default = 1
}
variable "subdomain" {
  default = "eschool"
}
#____________________________________________StateGitLab_registry
variable "token_registry" {
  default = "glpat-sadgresz-VxgEoq1s-W-"  #for read registry
}
variable "user_registry" {
  default = "yuriy.d"
}
variable "ci_registry" {
  default = "registry.gitlab.com"
}
variable "ci_project_group" {
  default = "/eschool/"
}
variable "ci_project_name_fr" {
  default = "frontend"
}
variable "ci_project_name_back" {
  default = "backend"
}
