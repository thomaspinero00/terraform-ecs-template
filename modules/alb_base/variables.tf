variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "Lista de subnets públicas para el ALB"
  type        = list(string)
}

variable "alb_sg_id" {
  description = "Security Group ID para el ALB"
  type        = string
}

variable "target_port" {
  description = "Puerto al que el Target Group va a enviar tráfico (ej. 80)"
  type        = number
  default     = 80
}

variable "health_check_path" {
  description = "Path de health check"
  type        = string
  default     = "/"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}
