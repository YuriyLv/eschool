#__________________________________add alias subdomain to dns name
resource "aws_route53_record" "dns_alb" {
  zone_id = data.terraform_remote_state.network.outputs.public_zone_id
  name    = "${var.subdomain}.${data.terraform_remote_state.network.outputs.public_zone_name}"
  type    = "A"
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}


