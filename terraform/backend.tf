terraform {
  backend "s3" {
    region         = "us-east-1"
    bucket         = "bluesea-terraform-state"
    encrypt        = true
    key            = "terraform/dev/devops101/main.tfstate"
    dynamodb_table = "bluesea-terraform-lock"
  }
}