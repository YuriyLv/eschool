locals {
  frontend_name  = "${var.environment_id}-frontend"
  backend_name   = "${var.environment_id}-backend"
  frontend_image = "-p 80:80 ${var.ci_registry}${var.ci_project_group}${var.ci_project_name_fr}:latest"
  backend_image  = "-p 8080:8080 -e DATASOURCE_URL='jdbc:mysql://${data.terraform_remote_state.rds.outputs.db_instance_address}:3306/${data.terraform_remote_state.rds.outputs.db_database_name}?useUnicode=true&characterEncoding=utf8' -e DATASOURCE_USERNAME='${data.terraform_remote_state.rds.outputs.db_instance_username}' -e DATASOURCE_PASSWORD='${data.terraform_remote_state.rds.outputs.db_instance_password}' ${var.ci_registry}${var.ci_project_group}${var.ci_project_name_back}:latest"
}