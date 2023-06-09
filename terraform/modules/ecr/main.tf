resource "aws_ecr_repository" "ecr" {
  name                 = "${var.project_name}/${var.application_name}"
  image_tag_mutability = "IMMUTABLE"
  tags                 = var.tags

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository_policy" "ecr_external_policy" {
  repository = aws_ecr_repository.ecr.name

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowKubeAccess",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : formatlist("arn:aws:iam::%s:root", var.accounts_with_access)
        },
        "Action" : [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
        ]
      }
    ]
  })
}
