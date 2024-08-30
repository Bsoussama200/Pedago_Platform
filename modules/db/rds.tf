module "db" {
  source                     = "terraform-aws-modules/rds/aws"
  identifier                 = var.db_name
  snapshot_identifier        = "arn:aws:rds:eu-west-3:471112993112:snapshot:complete"
  # snapshot_identifier        = "arn:aws:rds:eu-west-3:471112993112:snapshot:rds-prod"
  version                    = "5.2.0"
  engine                     = "postgres"
  engine_version             = var.db_engine_version
  family                     = var.db_family
  major_engine_version       = var.db_major_engine_version
  allow_major_version_upgrade = false
  auto_minor_version_upgrade = false
  instance_class             = var.db_instance_class
  allocated_storage          = 20
  storage_encrypted          = false
  kms_key_id                 = var.kms_key_arn
  multi_az                   = var.db_multi_az
  username                   = var.db_database_username
  password                   = random_password.password.result
  db_name                    = "postgres"
  # username                   = "iascholar"
  # password                   = "password"
  port                       = "5432"
  backup_retention_period = 7
  vpc_security_group_ids = [aws_security_group.db.id]
  maintenance_window     = var.db_maintenance_window
  apply_immediately      = var.db_apply_immediately
  create_random_password = false
  create_db_subnet_group = true
  max_allocated_storage= 500
  parameters = [
    {
      name  = "autovacuum"
      value = 1
    },
    {
      name  = "client_encoding"
      value = "utf8"
    },
        {
      name  = "rds.force_ssl"
      value = var.db_force_ssl
    }
  ]

  # monitoring_interval = "60"
  # monitoring_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.id}:role/rds-monitoring-role"

  iam_database_authentication_enabled = false
  copy_tags_to_snapshot               = true
  enabled_cloudwatch_logs_exports     = ["postgresql", "upgrade"]
  subnet_ids                          = [data.aws_subnet.db-a.id,data.aws_subnet.db-b.id]
  skip_final_snapshot                 = var.skip_final_snapshot
  final_snapshot_identifier_prefix    = "final-snapshot"
  deletion_protection                 = true

}
