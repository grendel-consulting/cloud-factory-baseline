data "aws_ssm_parameter" "security_contact" {
  name = "/aft/account-request/custom-fields/security-contact"
}

data "aws_ssm_parameter" "security_email" {
  name = "/aft/account-request/custom-fields/security-email"
}

data "aws_ssm_parameter" "security_phone" {
  name = "/aft/account-request/custom-fields/security-phone"
}

data "aws_ssm_parameter" "steampipe_cloud" {
  name = "/aft/account-request/custom-fields/steampipe-cloud"
}

data "aws_ssm_parameter" "steampipe_secret" {
  name = "/aft/account-request/custom-fields/steampipe-secret"
}

data "aws_ssm_parameter" "aikidodev_cloud" {
  name = "/aft/account-request/custom-fields/aikidodev-cloud"
}

data "aws_ssm_parameter" "aikidodev_secret" {
  name = "/aft/account-request/custom-fields/aikidodev-secret"
}
