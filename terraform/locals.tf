locals {
  region_code    = "ue1"
  region         = "us-east-1"
  environment    = "dev"
  workload_code  = "bluesea"
  account_number = data.aws_caller_identity.current.id
  accounts_with_access = [
    data.aws_caller_identity.current.id, #Bluesea
  ]

  project_name = "bluesea"
  application_names = [
    "mycalc-webapp"
  ]

  tags = {
    "app_group" = "bluesea",
    "backup"    = "false",
    "monitor"   = "false"
  }
}