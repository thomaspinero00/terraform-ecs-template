variable "ecs_cluster_name" {
  description = "Nombre del ECS Cluster"
  type        = string
}

variable "ecs_service_name" {
  description = "Nombre del ECS Service"
  type        = string
}

variable "min_capacity" {
  description = "Cantidad mínima de tareas ECS"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Cantidad máxima de tareas ECS"
  type        = number
  default     = 3
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}