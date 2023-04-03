#__________________________________copy playbook to ci-cd
resource "null_resource" "ansible_copy" {
  count      = var.bastion_count
  depends_on = [aws_instance.bastion, aws_instance.ci_cd]
  connection {
    host        = aws_instance.bastion[count.index].public_ip
    type        = "ssh"
    user        = var.bastion_user
    private_key = file(var.bastion_key)
  }
  provisioner "file" {
    source      = var.source_bastion_internal_key
    destination = var.destination_bastion_internal_key
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 ${var.destination_bastion_internal_key}",
    ]
  }
  provisioner "file" {
    source      = "${path.module}/ansible"
    destination = "/home/${var.bastion_user}/ansible"
  }
  provisioner "file" {
    content     = data.template_file.inventory.rendered
    destination = "/home/${var.bastion_user}/ansible/inventory"
  }
  provisioner "file" {
    content     = data.template_file.group_vars.rendered
    destination = "/home/${var.bastion_user}/ansible/group_vars/all"
  }
}

data "template_file" "inventory" {
  template = file("${path.module}/ansible/inventory")
  vars = {
    ci_cd_ips = join("\n", local.ci_cd_ips)
    monitor_ips = join("\n", local.monitor_ips) #monitoring
  }
}

data "template_file" "group_vars" {
  template = file("${path.module}/ansible/group_vars/all")
  vars = {
    bastion_user                     = var.bastion_user
    destination_bastion_internal_key = var.destination_bastion_internal_key
    gitlab_url                       = var.gitlab_url
    registration_token               = var.registration_token
    runner_tags_list                 = var.runner_tags_list
    runner_executor                  = var.runner_executor
  }
}

#__________________________________launch playbook
resource "null_resource" "ansible_start" {
  count      = var.bastion_count
  depends_on = [null_resource.ansible_copy]
  connection {
    host        = aws_instance.bastion[count.index].public_ip
    type        = "ssh"
    user        = var.bastion_user
    private_key = file(var.bastion_key)
  }
  provisioner "file" {
    source      = "${path.module}/templates/start_ansible.sh"
    destination = "/tmp/start_ansible.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "cd /home/ec2-user/.ssh",
      "cd /home/ec2-user/ansible",
      "chmod +x /tmp/start_ansible.sh",
      "/tmp/start_ansible.sh",
    ]
  }
}


