variable "environment" {
    default = "developer"
  
}
variable "project_name" {
    default = "cluster"
  
}
variable "common_tags" {
    default = {
        Project = "cluster"
        Environment = "developer"
        Terraform = "true"
    }
}


variable "zone_id" {
    default = "Z070371924EXWCP8HF566"
}

variable "domain_name" {
    default = "srikanthaws.fun"
}