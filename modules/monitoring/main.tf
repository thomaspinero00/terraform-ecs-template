# --- CPU Alta
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "${var.ecs_service_name}-high-cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = var.high_cpu_threshold
  alarm_description   = "High CPU on ECS Service"
  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = var.ecs_service_name
  }
  alarm_actions = concat(var.high_cpu_actions, var.notification_actions)

}

# --- CPU Baja
resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  alarm_name          = "${var.ecs_service_name}-low-cpu"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = var.low_cpu_threshold
  alarm_description   = "Low CPU on ECS Service"
  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = var.ecs_service_name
  }

  alarm_actions = concat(var.low_cpu_actions, var.notification_actions)

}

# --- Memoria Alta
resource "aws_cloudwatch_metric_alarm" "high_memory" {
  alarm_name          = "${var.ecs_service_name}-high-memory"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = var.high_memory_threshold
  alarm_description   = "High Memory on ECS Service"
  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = var.ecs_service_name
  }

  alarm_actions = concat(var.high_memory_actions, var.notification_actions)

}

# --- Memoria Baja
resource "aws_cloudwatch_metric_alarm" "low_memory" {
  alarm_name          = "${var.ecs_service_name}-low-memory"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = var.low_memory_threshold
  alarm_description   = "Low Memory on ECS Service"
  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = var.ecs_service_name
  }

  alarm_actions = concat(var.low_memory_actions, var.notification_actions)

}
