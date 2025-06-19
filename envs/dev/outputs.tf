
output "url" {
  description = "app url"
  value       = "https://${module.route53_acm.app_url}"
}
