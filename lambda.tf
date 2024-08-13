resource "aws_cloudwatch_log_group" "function_group" {
  name              = "/aws/lambda/${var.basename}"
  retention_in_days = var.log_retention_days
}

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "lambda_execution_role" {
  name                = "${var.basename}-lambda-role"
  description         = "Execution role for ${var.basename} lambda funtion"
  assume_role_policy  = data.aws_iam_policy_document.lambda_assume_role_policy.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
}


resource "aws_lambda_function" "this" {
  function_name = var.basename
  description   = "Lambda function for ${var.basename}"
  s3_bucket     = module.code_bucket.s3_bucket_id
  s3_key        = local.code_object_key
  role          = aws_iam_role.lambda_execution_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.10"
  timeout       = 60

  depends_on = [
    aws_cloudwatch_log_group.function_group,
    resource.aws_s3_object.code_zip
  ]

  lifecycle {
    ignore_changes = [s3_bucket, s3_key]
  }
}
