module "code_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~>4.1.2"

  bucket_prefix = "${var.basename}-lambda-code"
  force_destroy = true
}

resource "aws_s3_object" "code_zip" {
  bucket = module.code_bucket.s3_bucket_id
  key    = local.code_object_key
  source = "${path.module}/placeholder_function/lambda_function.zip"

  lifecycle {
    ignore_changes = all
  }
}
