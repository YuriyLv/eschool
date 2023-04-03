#____________________________________________backend
terraform {
  backend "s3" {
    region         = "eu-west-1"
    bucket         = "netw-bas-cicd-rds-tests"
    key            = "ec2s/terraform.tfstate"
    dynamodb_table = "netw-bas-cicd-rds-tests"
  }
}
#____________________________________________State
variable "region" {
  default = "eu-west-1"
}
variable "environment_name" {
  default = "develop"
}
variable "environment_id" {
  default = "dev"
}
variable "state_bucket" {
  default = "netw-bas-cicd-rds-tests"
}
variable "purpose" {
  default = "developing"
}
variable "state_bucket_key" {
  default = "ec2s/terraform.tfstate"
}
variable "table_name" {
  default = "netw-bas-cicd-rds-tests"
}

#____________________________________________Bastion
variable "bastion_count" {
  default = "1"
}
variable "bastion_instance_type" {
  default = "t2.micro"
}
variable "bastion_volume_size" {
  default = "10"
}
variable "bastion_user" {
  default = "ec2-user"
}

#____________________________________________CI/CD
variable "ci_cd_count" {
  default = "1"
}
variable "ci_cd_instance_type" {
  default = "t3.small"
}
variable "ci_cd_volume_size" {
  default = "12"
}
#____________________________________________monitor
variable "monitor_count" {
  default = "1"
}
variable "monitor_linux" {
  default = "1"
  # 1 - ubuntu
  # other - aws-linux
}
variable "monitor_instance_type" {
  default = "t3.small"
}
variable "monitor_volume_size" {
  default = "15"
}
variable "destination_monitor_internal_key" {
  default = "/home/ubuntu/id_rsa"
}
variable "monitor_user" {
  default = "ubuntu"
}

#____________________________________________Keys

variable "bastion_key_name" {
  default = "Ireland"                         # aws key name for local connect to bastion
}
variable "internal_key_name" {
  default = "id_rsa-pub"                      # aws key name for cicd to take connect from bastion
}
variable "destination_bastion_internal_key" {
  default = "/home/ec2-user/.ssh/id_rsa"      # place key on bastion for connect to cicd
}
variable "bastion_key" {
  default = "/home/dozee/.ssh/Ireland.pem"   # local key for connect to bastion
}
variable "source_bastion_internal_key" {
  default = "/home/dozee/.ssh/id_rsa"        # local key for bastion can take connect to cicd
}
variable "internal_key_path" {
  default = "/home/dozee/.ssh/id_rsa.pub"    # local key for copy to aws and cicd to take connect from bastion
}
#____________________________________________MY IP
variable "my_ip" {
  default = "176.117.187.49/32"
}
#____________________________________________Ansible
variable "gitlab_url" {
  default = "https://gitlab.com/"
}
variable "registration_token" {
  default = "GR1qwd-XVTpn1mS-SeWPDk4ab"
}
variable "runner_tags_list" {
  default = "frontend, backend, infra"
}
variable "runner_executor" {
  default = "shell"
}
