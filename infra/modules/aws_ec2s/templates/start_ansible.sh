#!/bin/bash
sleep 10
sudo cd /home/ec2-user/ansible
sudo cat /home/ec2-user/ansible/inventory
sudo ansible-playbook /home/ec2-user/ansible/playbook.yml || true