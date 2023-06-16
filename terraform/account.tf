resource "aws_account_alternate_contact" "security" {

  alternate_contact_type = "SECURITY"

  name          = data.aws_ssm_parameter.security_contact.value
  title         = "Director"
  email_address = data.aws_ssm_parameter.security_email.value
  phone_number  = data.aws_ssm_parameter.security_phone.value
}

# We intend to rely on AWS SSO for user management, so
# we will not create any IAM users or passwords.
resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 45
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  password_reuse_prevention      = 15
  max_password_age               = 5
  allow_users_to_change_password = true
}

resource "aws_ebs_encryption_by_default" "primary_region" {
  enabled = true
}

# resource "aws_ebs_encryption_by_default" "backup_region" {
#   provider = aws.backup
#   enabled  = true
# }

# resource "aws_ebs_encryption_by_default" "global_region" {
#   provider = aws.global
#   enabled  = true
# }

resource "aws_s3_account_public_access_block" "strict" {
  block_public_acls   = true
  block_public_policy = true
}

resource "aws_default_security_group" "primary_region" {
  vpc_id = data.aws_vpc.primary_region.id
}

# resource "aws_default_security_group" "backup_region" {
#   provider = aws.backup
#   vpc_id   = data.aws_vpc.backup_region.id
# }

data "aws_vpc" "primary_region" {
  default = true
}

# data "aws_vpc" "backup_region" {
#   provider = aws.backup
#   default  = true
# }
