locals {
  name="${var.project_name}-${var.environment}"
  vpc_id=data.aws_ssm_parameter.vpc_id.value
  public_subnet_id = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[0]
  private_subnet_ids = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
  eks_control_plane_sg_id =data.aws_ssm_parameter.eks_control_plane_sg_id.value
  eks_node_sg_id =data.aws_ssm_parameter.eks_node_sg_id.value
}