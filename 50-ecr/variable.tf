variable "sg_tags" {
    default = {}
  
}

variable "project_name" {
    default = "cluster"
}

variable "environment"{
    default = "developer"
}

variable "common_tags" {
    default = {
        Project = "cluster"
        Environment = "developer"
        Terraform = "true"
    }
}