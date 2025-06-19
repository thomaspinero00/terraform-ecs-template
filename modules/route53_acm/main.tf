resource "aws_route53_zone" "main" {
  name = var.domain_name
}

resource "aws_acm_certificate" "cert" {
  domain_name       = "${var.subdomain}.${var.domain_name}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Project = var.project_name
  }
}

# Convertimos el set en lista y accedemos de forma segura al primer elemento
locals {
  validation_option = element(tolist(aws_acm_certificate.cert.domain_validation_options), 0)
}

resource "aws_route53_record" "cert_validation" {
  name    = local.validation_option.resource_record_name
  type    = local.validation_option.resource_record_type
  zone_id = aws_route53_zone.main.zone_id
  records = [local.validation_option.resource_record_value]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}

resource "aws_route53_record" "app_alias" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "${var.subdomain}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}
