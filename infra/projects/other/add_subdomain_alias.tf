provider "aws" {
  region = var.region
}
data "aws_route53_zone" "public" {
  name = var.public_zone_name
}
resource "aws_route53_record" "add_subdomain" {
  zone_id = data.aws_route53_zone.public.id
  name    = "${var.subdomain}.${var.public_zone_name}"
  type    = "A"
  alias {
    name                   = var.resource_name
    zone_id                = var.resource_id
    evaluate_target_health = true
  }
}
variable "region" {
  default = "eu-west-1"
}
variable "public_zone_name" {
  default     = "dozee.click"
}
variable "subdomain" {
  default = "helper"
}
variable "resource_name" {
  default = "name-qwerty"
}
variable "resource_id" {
  default = "id-12345678"
}