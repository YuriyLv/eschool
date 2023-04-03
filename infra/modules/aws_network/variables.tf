variable "region" {
  default = ""
}
variable "environment_name" {
  default = ""
}
variable "environment_id" {
  default = ""
}
variable "purpose" {
  default = ""
}
variable "state_bucket" {
  default = ""
}
variable "zones" {
  default = ""
}
variable "vpc_cidr" {
  default = ""
}
variable "public_zone_name" {
  default = ""
}
variable "has_single_nat_gateway" {
  type        = bool
  default     = true
}