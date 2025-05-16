locals {
  ami_id= data.aws_ami.bastion.id
  instance_type="t3.micro"
  resource_name="${var.project_name}-${var.environment}-bastion"
  public_subnet_id = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[0]
  private_subnet_id = split(",", data.aws_ssm_parameter.private_subnet_ids.value)[0]
}
