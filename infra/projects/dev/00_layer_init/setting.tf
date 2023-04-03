#____________________________________________backend
terraform {
    backend "s3" {
        region         = "eu-west-1"
        bucket         = "netw-bas-cicd-rds-tests"
        key            = "state-bucket/terraform.tfstate"
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
variable "table_name" {
    default = "netw-bas-cicd-rds-tests"
}
variable "purpose" {
    default = "developing"
}
variable "state_bucket_key" {
    default = "state-bucket/terraform.tfstate"
}
