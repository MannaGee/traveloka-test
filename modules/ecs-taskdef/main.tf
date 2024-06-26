provider "aws" {
  region = "us-east-1"
}

resource "aws_ecs_task_definition" "custom_task_definition" {
  family                   = var.family
  container_definitions    = var.container_definitions
  network_mode             = var.network_mode
  requires_compatibilities = var.use_fargate ? ["FARGATE"] : var.requires_compatibilities
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn
}
output "task_definition_arn" {
  value = aws_ecs_task_definition.custom_task_definition.arn
}
