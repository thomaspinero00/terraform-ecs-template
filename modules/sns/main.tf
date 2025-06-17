resource "aws_sns_topic" "sns-topic" {
  name = "${var.project_name}-sns-topic"
}

resource "aws_sns_topic_subscription" "emails" {
  for_each  = toset(var.emails)
  topic_arn = aws_sns_topic.sns-topic.arn
  protocol  = "email"
  endpoint  = each.value
}
