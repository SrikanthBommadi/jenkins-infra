module "mysql_sg" {
    source = "git::https://github.com/SrikanthBommadi/Terraform//sg-ec2 vpc?ref=main"
    common-tags = var.common_tags
    environment = var.environment
    project = var.project_name
    sg_Name = "mysql"
    sg_description = "created for mysql eks"
    vpc_id =data.aws_ssm_parameter.vpc_id.value
}

module "bastion_sg" {     ####its for jumping value or jump host
    source = "git::https://github.com/SrikanthBommadi/Terraform//sg-ec2 vpc?ref=main"
    common-tags = var.common_tags
    environment = var.environment
    project = var.project_name
    sg_Name = "bastion "
    sg_description = "created for bastion eks"
    vpc_id =data.aws_ssm_parameter.vpc_id.value
}

module "alb_ingress_sg" {
    source = "git::https://github.com/SrikanthBommadi/Terraform//sg-ec2 vpc?ref=main"
    common-tags = var.common_tags
    environment = var.environment
    project = var.project_name
    sg_Name = "app-alb-ingress "
    sg_description = "created for app alb ingress eks"
    vpc_id =data.aws_ssm_parameter.vpc_id.value
}

module "vpn_sg" {
    source = "git::https://github.com/SrikanthBommadi/Terraform//sg-ec2 vpc?ref=main"
    common-tags = var.common_tags
    environment = var.environment
    project = var.project_name
    sg_Name = "vpn "
    sg_description = "created for vpn eks"
    vpc_id =data.aws_ssm_parameter.vpc_id.value
}

module "eks_control_plane_sg" {
    source = "git::https://github.com/SrikanthBommadi/Terraform//sg-ec2 vpc?ref=main"
    common-tags = var.common_tags
    environment = var.environment
    project = var.project_name
    sg_Name = "control-plane "
    sg_description = "created for control plane"
    vpc_id =data.aws_ssm_parameter.vpc_id.value
}
module "eks_node_sg" {
    source = "git::https://github.com/SrikanthBommadi/Terraform//sg-ec2 vpc?ref=main"
    common-tags = var.common_tags
    environment = var.environment
    project = var.project_name
    sg_Name = "eks-node"
    sg_description = "created for eks-node"
    vpc_id =data.aws_ssm_parameter.vpc_id.value
}

###################################RESOURCES#########################################
resource "aws_security_group_rule" "eks_control_plane_node" {
  type              = "ingress"    ##ingressssss value###
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  source_security_group_id = module.eks_node_sg.sg_id
  security_group_id = module.eks_control_plane_sg.sg_id
}
resource "aws_security_group_rule" "eks_node_eks_control_plane" {
  type              = "ingress"    ##ingressssss value###
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  source_security_group_id = module.eks_control_plane_sg.sg_id
  security_group_id = module.eks_node_sg.sg_id
}
# resource "aws_security_group_rule" "node_alb_ingress" {
#   type              = "ingress"    ##ingressssss value###
#   from_port         = 30000
#   to_port           = 32762
#   protocol          = "tcp"
#   source_security_group_id = module.alb_ingress_sg.sg_id
#   security_group_id = module.eks_node_sg.sg_id
# }
resource "aws_security_group_rule" "node_vpc" {
  type              = "ingress"    ##ingressssss value###
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks = ["10.0.0.0/16"] ##our internall
  security_group_id = module.eks_node_sg.sg_id
}
resource "aws_security_group_rule" "node_bastion" {
  type              = "ingress"    ##ingressssss value###
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.sg_id ##our internall
  security_group_id = module.eks_node_sg.sg_id
}
resource "aws_security_group_rule" "alb_ingress_bastion" {
  type              = "ingress"    ##ingressssss value###
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.sg_id
  security_group_id = module.alb_ingress_sg.sg_id
}

resource "aws_security_group_rule" "alb_ingress_bastion_https" {
  type              = "ingress"    ##ingressssss value###
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.sg_id
  security_group_id = module.alb_ingress_sg.sg_id
}

resource "aws_security_group_rule" "alb_ingress_public_https" {
  type              = "ingress"    ##ingressssss value###
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.alb_ingress_sg.sg_id
}
resource "aws_security_group_rule" "bastion_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion_sg.sg_id
} 
resource "aws_security_group_rule" "mysql_bastion" { ##rds
  type              = "ingress"
  from_port         = 3306    ####MYSQL###
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.sg_id
  security_group_id = module.mysql_sg.sg_id
}
resource "aws_security_group_rule" "mysql_eks_node" { ##rds
  type              = "ingress"
  from_port         = 3306    ####MYSQL###
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.eks_node_sg.sg_id
  security_group_id = module.mysql_sg.sg_id
}

resource "aws_security_group_rule" "eks_control_plane_bastion" { ##rds
  type              = "ingress"
  from_port         = 443   ####MYSQL###
  to_port           = 443
  protocol          = "tcp"
  source_security_group_id = module.bastion_sg.sg_id
  security_group_id = module.eks_control_plane_sg.sg_id
}

resource "aws_security_group_rule" "node_alb_ingress" {
  type              = "ingress"    ##ingressssss value###
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.alb_ingress_sg.sg_id
  security_group_id = module.eks_node_sg.sg_id
}