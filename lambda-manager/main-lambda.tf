# Lambda

data "archive_file" "lambda" {
  type        = "zip"
  source_dir = local.lambda_dir
  output_path = local.lambda_zip
}

resource "aws_lambda_function" "lambda" {

  function_name = local.lambda_name
  role = aws_iam_role.lambda.arn
  handler = "handler.sh"
  runtime = "provided"
  timeout = 900 # 15 minutes

  filename = local.lambda_zip
  source_code_hash = data.archive_file.lambda.output_base64sha256

  tags = local.tags
}

resource "aws_cloudwatch_event_rule" "lambda_schedule" {
  name = local.lambda_name
  schedule_expression = "rate(5 minutes)"
}

resource "aws_cloudwatch_event_target" "lambda_event_target" {
  rule = aws_cloudwatch_event_rule.lambda_schedule.name
  target_id = "FirewallManagement"
  arn = aws_lambda_function.lambda.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.lambda_schedule.arn
}
