data "aws_route53_zone" "public" {
  name = var.public_zone_name
}