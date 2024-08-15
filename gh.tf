resource "github_repository" "code" {
  name        = "${aws_lambda_function.this.function_name}-code"
  description = "Code for the ${aws_lambda_function.this.function_name} Lambda function."

  visibility = "private"

  template {
    owner      = "nphilbrook"
    repository = "lambda-function-template"
  }
}

resource "github_actions_variable" "bucket_name" {
  repository    = github_repository.code.name
  variable_name = "S3_BUCKET"
  value         = module.code_bucket.s3_bucket_id
}

resource "github_actions_variable" "function_name" {
  repository    = github_repository.code.name
  variable_name = "FUNCTION_NAME"
  value         = aws_lambda_function.this.function_name
}
