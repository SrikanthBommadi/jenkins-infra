resource "aws_instance" "bastion" {
    ami = local.ami_id
    subnet_id = local.public_subnet_id
    instance_type = local.instance_type
    vpc_security_group_ids = [data.aws_ssm_parameter.bastion_sg_id.value]
    tags = merge(
        var.common_tags,
        var.sg_tags,
        {
            Name= local.resource_name
        }
    )

# root_block_device {
#     volume_size = 50  # Set root volume size to 50GB
#     volume_type = "gp3"  # Use gp3 for better performance (optional)
#   }

#  provisioner "remote-exec" {
#     inline = [
#       "sudo dnf -y install dnf-plugins-core",
#       "sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo",
#       "sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin",
#       "sudo systemctl enable --now docker",
#       "sudo systemctl start docker",
#       "sudo usermod -aG docker ec2-user"
#     ]
#   }
#   connection {
#     type        = "ssh"
#     user        = "ec2-user"
#     password    = "DevOps321"
#     host        = self.public_ip
#   }
  user_data = file("docker.sh")
}
###this for new volume create only
# resource "aws_ebs_volume" "project" {
#   availability_zone = "us-east-1b"  # Choose the availability zone where you want to create the volume
#   size              = 50            # Size in GB
#   tags = {
#     Name = "project"
#   }
# }
