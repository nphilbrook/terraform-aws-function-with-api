terraform {
  required_version = "~>1.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.55"
    }
    # archive = {
    #   source  = "hashicorp/archive"
    #   version = "~>2.4"
    # }
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      "created-by"       = "terraform"
      "source-workspace" = terraform.workspace
    }
  }
}
