variable "db_name" {}
variable "vpc_name" {}
variable "db_subnet_1" {}
variable "db_subnet_2" {}
variable db_engine_version{}
variable db_family{}
variable db_major_engine_version{}
variable db_instance_class{}

variable db_multi_az{}
variable kms_key_arn{}
variable db_database_username{}

variable db_maintenance_window{}
variable db_apply_immediately{}
variable "db_force_ssl" {}
variable "skip_final_snapshot" {}
