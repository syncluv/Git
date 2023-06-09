provider "aws" {
  profile = var.aws_profile
  region  = local.region

  default_tags {
    tags = {
      env               = "aws::${local.environment}:${local.project_name}:"
      terraform_managed = "true"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

terraform {
  required_version = ">= 1.2.0"
}
