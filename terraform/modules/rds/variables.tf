variable "vpc_id" {
    type = string
}

variable "subnet_ids" {
    type = list(string)
}

variable "ecs_sg_id" {
    type = string
}

variable "db_password" {
    type = string
}

variable "rds_sg_id" {
    type = string
}