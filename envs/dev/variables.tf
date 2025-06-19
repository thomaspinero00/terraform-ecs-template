variable "project_name" {
  description = "Nombre base del proyecto, usado como prefijo para todos los recursos"
  type        = string
}

variable "domain_name" {
  description = "Dominio principal (e.g. tradenethub.com)"
  type        = string
}

variable "subdomain" {
  description = "Subdominio para exponer la app (e.g. mytest)"
  type        = string
}

variable "azs" {
  description = "Availability Zones a utilizar"
  type        = list(string)
}

variable "cluster_name" {
  description = "Nombre del ECS Cluster"
  type        = string
}

variable "container_image" {
  description = "Imagen del contenedor a usar en ECS"
  type        = string
}

variable "desired_count" {
  description = "Cantidad deseada de tareas ECS en ejecución"
  type        = number
}

variable "min_capacity" {
  description = "Capacidad mínima del autoscaling para ECS"
  type        = number
}

variable "max_capacity" {
  description = "Capacidad máxima del autoscaling para ECS"
  type        = number
}

variable "high_cpu_threshold" {
  description = "Umbral alto de uso de CPU para escalar hacia arriba"
  type        = number
}

variable "low_cpu_threshold" {
  description = "Umbral bajo de uso de CPU para escalar hacia abajo"
  type        = number
}

variable "high_memory_threshold" {
  description = "Umbral alto de uso de memoria para escalar hacia arriba"
  type        = number
}

variable "low_memory_threshold" {
  description = "Umbral bajo de uso de memoria para escalar hacia abajo"
  type        = number
}

variable "emails" {
  description = "Lista de emails que recibirán notificaciones SNS"
  type        = list(string)
}
