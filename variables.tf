variable "basename" {
  type        = string
  description = "The basename of your function which will be used in all created AWS objects"
}

variable "region" {
  type        = string
  description = "The AWS region to use."
  default     = "us-east-2"
}

variable "log_retention_days" {
  type        = number
  description = "Number of days to retain CloudWatch logs."
  default     = 14
}

variable "enable_api_gateway_logging" {
  type        = bool
  description = "Whether to enable API Gateway logging."
  default     = true
}

variable "api_gateway_logging_level" {
  type        = string
  description = "Log level for API Gateway execution logging."
  default     = "INFO"
  validation {
    condition     = contains(["OFF", "ERROR", "INFO"], var.api_gateway_logging_level)
    error_message = "Invalid logging level specified."
  }
}
