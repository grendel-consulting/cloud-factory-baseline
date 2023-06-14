resource "aws_ssm_parameter" "steampipe_suffix" {
  name  = "/steampipe/suffix"
  type  = "String"
  value = "*"

  # Default wildcard to enable parameter to be created, new
  # suffix will be provided per connection in Steampipe Cloud
  lifecycle {
    ignore_changes = [value]
  }
}

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
            "sts:ExternalId" : "${data.aws_ssm_parameter.steampipe_secret.value}:${aws_ssm_parameter.steampipe_suffix.value}"
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
