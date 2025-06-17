output "cpu_high_alarm_arn" {
  value = aws_cloudwatch_metric_alarm.high_cpu.arn
}

output "cpu_low_alarm_arn" {
  value = aws_cloudwatch_metric_alarm.low_cpu.arn
}

output "memory_high_alarm_arn" {
  value = aws_cloudwatch_metric_alarm.high_memory.arn
}

output "memory_low_alarm_arn" {
  value = aws_cloudwatch_metric_alarm.low_memory.arn
}
