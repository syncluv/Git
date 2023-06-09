module "github_action_role" {
  source = "./modules/githubactions_ecr_role"

  providers = {
    aws = aws
  }

  repository_access_list = [
    "repo:ferzconnect01/devops101:*",
  ]

  ecr_registry = [
    module.ecr_repositories["mycalc-webapp"].ecr_repository_arn,
  ]

  region_code   = local.region_code
  region        = local.region
  workload_code = local.workload_code
  tags          = local.tags
}