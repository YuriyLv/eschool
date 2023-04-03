variable "region" {
  default = ""
}
variable "environment_name" {
  default = ""
}
variable "environment_id" {
  default = ""
}
variable "state_bucket" {
  default = ""
}
variable "purpose" {
  default = ""
}
variable "state_bucket_key" {
  default = ""
}
variable "create_db_instance" {
  default = ""
}
variable "create_db_parameter_group" {
  default = ""
}
variable "rds_identifier" {
  default = ""
}
variable "rds_instance_class" {
  default = ""
}
variable "engine" {
  default = ""
}
variable "family" {
  default = ""
}
variable "major_engine_version" {
  default = ""
}
variable "rds_storage_size" {
  default = ""
}
variable "rds_storage_type" {
  default = ""
}
variable "engine_version" {
  default = ""
}
variable "db_password" {
  default = ""
}
variable "db_name" {
  default = ""
}
variable "username" {
  default = ""
}
variable "rds_parameters" {
  type = list(any)
  default = []
}
