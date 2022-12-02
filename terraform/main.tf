data "archive_file" "lambda_my_function" {
  type             = "zip"
  source_file      = "${path.module}/../build/main"
  output_file_mode = "0666"
  output_path      = "${path.module}/../build/main.zip"
}

resource "aws_lambda_function" "cloudwatch_export" {
  function_name = "test_lambda"
  filename      = data.archive_file.lambda_my_function.output_path
  role          = aws_iam_role.cloudwatch_export.arn
  handler       = "main"
  runtime       = "go1.x"

  environment {
    variables = {
      foo = "bar"
    }
  }
}

resource "aws_cloudwatch_event_rule" "cloudwatch_export" {
  name                = aws_lambda_function.cloudwatch_export.function_name
  description         = "CloudWatch log exports for ${var.log_group}"
  schedule_expression = var.schedule
}

resource "aws_cloudwatch_event_target" "lambda" {
  target_id = aws_lambda_function.cloudwatch_export.function_name
  rule      = aws_cloudwatch_event_rule.cloudwatch_export.name
  arn       = aws_lambda_function.cloudwatch_export.arn
  #input - (Optional) Valid JSON text passed to the target
  input = <<EOF
{"s3_bucket":"${var.s3_bucket}", "s3_prefix":"${var.s3_prefix}", "log_group":"${var.log_group}"}
EOF
}

resource "aws_lambda_permission" "events" {
  statement_id  = aws_lambda_function.cloudwatch_export.function_name
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.cloudwatch_export.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.cloudwatch_export.arn
}

resource "aws_iam_role" "cloudwatch_export" {
  name               = var.name
  description        = "Lambda role for CloudWatch Log exports"
  assume_role_policy = data.aws_iam_policy_document.cloudwatch_export_assume_role.json
}

data "aws_iam_policy_document" "cloudwatch_export_assume_role" {
  statement {
    sid     = "BasicLambdaExecution"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "cloudwatch_export" {
  name   = var.name
  role   = aws_iam_role.cloudwatch_export.id
  policy = data.aws_iam_policy_document.cloudwatch_export_inline.json
}

data "aws_iam_policy_document" "cloudwatch_export_inline" {
  statement {
    actions   = ["cloudwatch:*", "logs:*"]
    resources = ["*"]
  }
}