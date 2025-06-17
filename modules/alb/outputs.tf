output "alb_dns_name" {
  description = "Nombre DNS público del Application Load Balancer"
  value       = aws_lb.this.dns_name
}

output "target_group_arn" {
  description = "ARN del Target Group asociado al ALB"
  value       = aws_lb_target_group.this.arn
}
