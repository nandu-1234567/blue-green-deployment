resource "aws_ecs_cluster" "this" {
  name = "${var.project_name}-cluster1"
}

resource "aws_ecs_task_definition" "this" {
  family                   = "${var.project_name}-task1"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = var.execution_role_arn

  container_definitions = jsonencode([
    {
      name  = "strapi"
      image = var.image_uri

      portMappings = [
        {
          containerPort = 1337
          hostPort      = 1337
        }
      ]

      essential = true
    }
  ])
}

resource "aws_ecs_service" "this" {
  name            = "${var.project_name}-service1"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = [var.ecs_sg_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.blue_target_group_arn
    container_name   = "strapi"
    container_port   = 1337
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}
