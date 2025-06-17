output "cluster_id" {
  description = "ID del ECS Cluster creado"
  value       = aws_ecs_cluster.this.id
}

output "cluster_name" {
  description = "Nombre del ECS Cluster"
  value       = aws_ecs_cluster.this.name
}

output "service_name" {
  description = "Nombre del servicio ECS"
  value       = aws_ecs_service.app.name
}
