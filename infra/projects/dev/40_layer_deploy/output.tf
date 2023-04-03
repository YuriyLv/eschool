output "launch_template_frontend" {
  sensitive = true
  value     = module.aws_deploy.launch_template_frontend
}

