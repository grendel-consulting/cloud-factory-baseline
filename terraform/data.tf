data "aws_ssm_parameter" "steampipe_cloud" {
  name = "/aft/account-request/custom-fields/steampipe-cloud"
}

data "aws_ssm_parameter" "steampipe_secret" {
  name = "/aft/account-request/custom-fields/steampipe-secret"
}
