#____________________________________________backend
terraform {
  backend "s3" {
    region         = "eu-west-1"
    bucket         = "netw-bas-cicd-rds-tests"
    key            = "network/terraform.tfstate"
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
  default = "network/terraform.tfstate"
}
variable "table_name" {
  default = "netw-bas-cicd-rds-tests"
}
#____________________________________________Vpc
variable "has_single_nat_gateway" {
  description = "Toggle for environments to use 1 NAT gateway for all AZs"
  type        = bool
  default     = true
}
variable "zones" {
  type = list(string)
  default = [
    "eu-west-1a",
    "eu-west-1b",
    "eu-west-1c"
  ]
  description = "List of availability zones"
}
variable "vpc_cidr" {
  description = "VPC CIDR"
  default     = "192.168.0.0/25"
}
variable "public_zone_name" {
  description = "Public Hosted Zone Name"
  default     = "test.click"
}

