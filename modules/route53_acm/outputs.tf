output "certificate_arn" {
  value = aws_acm_certificate_validation.cert.certificate_arn
}

output "nameservers" {
  value = aws_route53_zone.main.name_servers
}

output "app_url" {
  value = aws_route53_record.app_alias.fqdn
}
