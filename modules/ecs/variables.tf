variable "cluster_name" {
  description = "Nombre del ECS Cluster"
  type        = string
}

variable "container_image" {
  description = "Imagen del contenedor NGINX"
  type        = string
  default     = "nginx:latest"
}

variable "task_execution_role_arn" {
  description = "ARN del Execution Role de ECS"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de IDs de subnets privadas"
  type        = list(string)
}

variable "security_group_ids" {
  description = "IDs de los Security Groups que se le asignan a las tasks"
  type        = list(string)
}

variable "desired_count" {
  description = "Cantidad inicial de tasks"
  type        = number
  default     = 1
}

variable "target_group_arn" {
  description = "ARN del Target Group del ALB"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}
