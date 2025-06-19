variable "alb_arn" {
  type        = string
  description = "ARN del ALB"
}

variable "target_group_arn" {
  type        = string
  description = "ARN del Target Group"
}

variable "certificate_arn" {
  type        = string
  description = "ACM certificate ARN for HTTPS"
}
