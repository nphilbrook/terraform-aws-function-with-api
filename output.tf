output "bucket_name" {
  value = module.code_bucket.s3_bucket_id
}

output "api_gateway_url" {
  description = "API Gateway URL."
  value       = "${aws_api_gateway_stage.this.invoke_url}/${aws_api_gateway_resource.this.path_part}"
}

output "lambda_invoke_arn" {
  description = "The Invoke ARN of the Lambda function."
  value       = aws_lambda_function.this.invoke_arn
}

