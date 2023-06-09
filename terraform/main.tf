module "ecr_repositories" {
  source = "./modules/ecr"

  for_each = toset(local.application_names)

  providers = {
    aws = aws
  }

  account_number       = local.account_number
  accounts_with_access = local.accounts_with_access
  project_name         = local.project_name
  application_name     = each.key
  tags                 = local.tags
}
