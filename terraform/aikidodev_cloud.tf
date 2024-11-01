resource "aws_iam_role" "aikidodev_cloud_role" {
  name = "aikido-security-readonly-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "AikidoDevCloudAssumeRole"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_ssm_parameter.aikidodev_cloud.value}:role/service-role/lambda-aws-cloud-findings-role-uox26vzd"
        },
        Condition : {
          StringEquals : {
            "sts:ExternalId" : data.aws_ssm_parameter.aikidodev_secret.value
          }
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "aikidodev_cloud_role_attach" {
  role       = aws_iam_role.aikidodev_cloud_role.name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}

resource "aws_iam_role_policy" "aikido-security-policy" {
  name = "aikido-security-policy"
  role = aws_iam_role.aikidodev_cloud_role.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "backup:ListBackupPlans",
          "backup:GetBackupPlan",
          "backup:ListProtectedResources",
          "budgets:ViewBudget",
          "inspector2:*"
        ],
        "Resource" : "*",
        "Effect" : "Allow"
      }
    ]
  })
}
