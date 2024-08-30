resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%^&*()-_?"
}

resource "aws_secretsmanager_secret" "superuser_db_credentials" {
  name        = "${var.db_name}/admin_user"
  kms_key_id  = var.kms_key_arn
  description = "Superuser credentials for ${var.db_name}"
}

resource "aws_secretsmanager_secret_version" "superuser_db_credentials" {
  secret_id     = aws_secretsmanager_secret.superuser_db_credentials.id
  secret_string = jsonencode(local.db_creds)
}

