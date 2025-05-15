variable "sg_tags" {
    default = {}
  
}

variable "project_name" {
    default = "terraform"
}

variable "environment"{
    default = "developer"
}

variable "common_tags" {
    default = {
        Project = "srikanth"
        Environment = "terraform"
        Terraform = "true"
    }
}