variable "project_name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "ecs_sg_id" {
  type = string
}

variable "blue_target_group_arn" {
  type = string
}

variable "execution_role_arn" {
  type = string
}

variable "image_uri" {
  type = string
}