#____________________________________________backend
terraform {
  backend "s3" {
    region         = "eu-west-1"
    bucket         = "netw-bas-cicd-rds-tests"
    key            = "rds/terraform.tfstate"
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
  default = "rds/terraform.tfstate"
}
variable "table_name" {
  default = "netw-bas-cicd-rds-tests"
}
#____________________________________________db
variable "create_db_instance" {
  default = true
}
variable "create_db_parameter_group" {
  default = true
}
variable "rds_identifier" {
  default = "eschool"
}
variable "rds_instance_class" {
  default = "db.t3.micro"
}
variable "engine" {
  default = "mysql"
}
variable "family" {
  default = "mysql8.0"
}
variable "major_engine_version" {
  default = "8.0"
}
variable "rds_storage_size" {
  default = 25
}
variable "rds_storage_type" {
  default = "gp2"
}
variable "engine_version" {
  default = "8.0.31"
}
variable "rds_parameters" {
  type = list(any)
  default = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]
}
variable "db_name" {
  default = "eschool"
}
variable "username" {
  default = "root"
}
variable "db_password" {
  default = "rootroot"
}
