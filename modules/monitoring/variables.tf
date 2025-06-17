variable "ecs_cluster_name" {
  description = "ECS Cluster Name"
  type        = string
}

variable "ecs_service_name" {
  description = "ECS Service Name"
  type        = string
}

variable "high_cpu_threshold" {
  description = "CPU % para alarma de alta utilización"
  type        = number
  default     = 80
}

variable "low_cpu_threshold" {
  description = "CPU % para alarma de baja utilización"
  type        = number
  default     = 30
}

variable "high_memory_threshold" {
  description = "Memoria % para alarma de alta utilización"
  type        = number
  default     = 80
}

variable "low_memory_threshold" {
  description = "Memoria % para alarma de baja utilización"
  type        = number
  default     = 30
}

variable "high_cpu_actions" {
  type    = list(string)
  default = []
}
variable "low_cpu_actions" {
  type    = list(string)
  default = []
}

variable "high_memory_actions" {
  type    = list(string)
  default = []
}
variable "low_memory_actions" {
  type    = list(string)
  default = []
}

variable "notification_actions" {
  type    = list(string)
  default = []
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}