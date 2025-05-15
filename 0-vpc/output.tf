# output "aws_subnet_info" {
#     value = module.vpc.subnet_info
  
# }
# output "vpc_id" {
#     value = aws_vpc.main.vpc_id
  
# }

output "public_subnet_ids" {
    value = module.vpc.public_subnet_ids
  
}

# public_subnet_ids = [
#   "subnet-0878a360d0ab881ba",
#   "subnet-029f22d46edb6d1e3",
# ]
