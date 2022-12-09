resource "aws_cloudwatch_log_group" "teamcity-logs" {
  name = "teamcity-logs-group"
  tags = var.tags
}

resource "aws_cloudwatch_log_stream" "tc-logs-stream" {
  name           = "tc-logs-stream"
  log_group_name = aws_cloudwatch_log_group.teamcity-logs.name
}