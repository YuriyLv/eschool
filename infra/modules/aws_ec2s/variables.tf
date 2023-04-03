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
variable "bastion_count" {
  default = ""
}
variable "bastion_instance_type" {
  default = ""
}
variable "bastion_key_name" {
  default = ""
}
variable "my_ip" {
  default = ""
}
variable "bastion_volume_size" {
  default = ""
}
variable "bastion_user" {
  default = ""
}
variable "bastion_key" {
  default = ""
}
variable "source_bastion_internal_key" {
  default = ""
}
variable "destination_bastion_internal_key" {
  default = ""
}
variable "ci_cd_count" {
  default = ""
}
variable "ci_cd_instance_type" {
  default = ""
}
variable "internal_key_name" {
  default = ""
}
variable "internal_key_path" {
  default = ""
}
variable "ci_cd_volume_size" {
  default = ""
}
variable "gitlab_url" {
  default = ""
}
variable "registration_token" {
  default = ""
}
variable "runner_tags_list" {
  default = ""
}
variable "runner_executor" {
  default = ""
}

#---------------------------monitoring
variable "monitor_count" {
  default = ""
}
variable "monitor_aws_linux_count" {
  default = ""
}
variable "monitor_instance_type" {
  default = ""
}
variable "monitor_volume_size" {
  default = ""
}
variable "destination_monitor_internal_key" {
  default = ""
}
variable "monitor_user" {
  default = ""
}
variable "monitor_linux" {
  default = ""
}

