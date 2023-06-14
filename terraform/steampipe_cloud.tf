resource "aws_iam_role" "steampipe_cloud_role" {
  name = "steampipe_cloud"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "SteampipeCloudAssumeRole"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_ssm_parameter.steampipe_cloud.value}:root"
        },
        Condition : {
          StringEquals : {
            "sts:ExternalId" : data.aws_ssm_parameter.steampipe_secret.value
          }
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "steampipe_cloud_role_attach" {
  role       = aws_iam_role.steampipe_cloud_role.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
