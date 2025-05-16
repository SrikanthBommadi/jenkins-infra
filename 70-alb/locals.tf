locals {  #your split this because in parameter StringList but you want List
  public_subnet_ids =split(",", data.aws_ssm_parameter.public_subnet_ids.value) 
  alb_ingress_sg_id = data.aws_ssm_parameter.alb_ingress_sg_id.value
  certificate_arn=data.aws_ssm_parameter.alb_ingress_certificate_arn.value
  private_subnet_ids = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  
}