

resource "aws_route53_zone" "primary" {
  count = var.domain_zone_exist ? 0 : 1
  name  = var.domain
}

data "aws_route53_zone" "primary" {
  count = var.domain_zone_exist ? 1 : 0
  name  = var.domain
}
locals {
  dns_zone_id = var.domain_zone_exist ? data.aws_route53_zone.primary[0].zone_id : aws_route53_zone.primary[0].zone_id 
  subdomain   = var.environment_name == "production" ? "" : "${var.environment_name}."
}
resource "aws_route53_record" "root" {
  zone_id = local.dns_zone_id
  name    = "${local.subdomain}${var.domain}"
  type    = "A"
  alias {
    name                   = var.load_balancer_dns_name
    zone_id                = var.load_balancer_zone_id
    evaluate_target_health = true
  }
}
#check
