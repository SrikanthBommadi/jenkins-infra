variable "project_name" {
    default = "terraform"
}

variable "environment"{
    default = "developer"
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "common_tags" {
    default = {
        Project = "terraform"
        Environment = "developer"
        Terraform = "true"
    }
}

variable "vpc_tags" {
    default = {
        Purpose = "assignment"
    }
}

variable "public_subnet_cidrs" {
    default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
    default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "db_subnet_cidrs" {
    default = ["10.0.21.0/24", "10.0.22.0/24"]
}