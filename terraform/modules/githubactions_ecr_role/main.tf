locals {
  github_url = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_openid_connect_provider" "githubactions_oidc" {
  url = local.github_url

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

data "aws_caller_identity" "current" {
}

resource "aws_iam_role" "github_action" {
  name = "${var.region_code}-${var.workload_code}-github-action-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : aws_iam_openid_connect_provider.githubactions_oidc.arn
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringLike" : {
            "${trimprefix(aws_iam_openid_connect_provider.githubactions_oidc.url, "https://")}:sub" : var.repository_access_list
          }
        }
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy" "githubactions_policy" {
  name = "${var.region_code}-${var.workload_code}-ecr-ipl"
  role = aws_iam_role.github_action.id
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "ECRPush",
          "Effect" : "Allow",
          "Action" : [
            "ecr:BatchGetImage",
            "ecr:BatchCheckLayerAvailability",
            "ecr:CompleteLayerUpload",
            "ecr:GetDownloadUrlForLayer",
            "ecr:InitiateLayerUpload",
            "ecr:PutImage",
            "ecr:UploadLayerPart"
          ],
          "Resource" : var.ecr_registry
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "ecr:GetAuthorizationToken"
          ],
          "Resource" : [
            "*"
          ]
        }
      ]
    }
  )
}