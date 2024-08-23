locals {
  resource_name = "${var.project_name}-${terraform.workspace}"
  az_names = slice(data.aws_availability_zones.available.names, 0, 2)
  env=terraform.workspace
}
