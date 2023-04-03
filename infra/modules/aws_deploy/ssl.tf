resource "aws_acm_certificate" "ssl" {
  domain_name       = aws_route53_record.dns_alb.fqdn
  validation_method = "DNS"
}
resource "aws_route53_record" "cert_validation" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.ssl.domain_validation_options)[0].resource_record_name
  records         = [tolist(aws_acm_certificate.ssl.domain_validation_options)[0].resource_record_value]
  type            = tolist(aws_acm_certificate.ssl.domain_validation_options)[0].resource_record_type
  zone_id         = data.terraform_remote_state.network.outputs.public_zone_id
  ttl             = 60
}
resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.ssl.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}