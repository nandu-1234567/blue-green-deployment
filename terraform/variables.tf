variable "aws_region" {
  type = string
}

variable "project_name" {
  type = string
}

variable "image_uri" {
  type = string
}

variable "execution_role_arn" {
  type = string
}

variable "codedeploy_role_arn" {
  description = "ARN of the CodeDeploy role"
  type        = string
}
variable "alb_sg_id" {
  type = string
}
