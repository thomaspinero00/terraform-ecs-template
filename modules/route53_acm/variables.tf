# variables.tf
variable "project_name" {
  type = string
}

variable "domain_name" {
  description = "Root domain (e.g. tradenethub.com)"
  type        = string
}

variable "subdomain" {
  description = "Subdomain to use for the app (e.g. mytest)"
  type        = string
}

variable "alb_dns_name" {
  description = "DNS name of the ALB"
  type        = string
}

variable "alb_zone_id" {
  description = "Zone ID of the ALB"
  type        = string
}
