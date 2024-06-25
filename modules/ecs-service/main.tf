provider "aws" {
  region = "us-east-1"
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.55.0" # or use a stable version if the latest has issues
    }
  }
}

resource "aws_ecs_service" "custom_ecs_service" {
  name            = var.service_name
  cluster         = var.cluster_id
  task_definition = var.task_definition

  desired_count = var.desired_count

  launch_type = var.use_fargate ? "FARGATE" : "EC2"

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = var.security_group_ids
    assign_public_ip = var.assign_public_ip
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
}

output "service_id" {
  value = aws_ecs_service.custom_ecs_service.id
}