provider "aws" {
  region = "us-east-1"
}
terraform {
  backend "s3" {
    bucket         = "arq-terraform-bucket" # Replace with your S3 bucket name
    key            = "GHA/terraform.tfstate"   # Replace with the desired path to the state file within the bucket
    region         = "us-east-1"                   # Replace with your AWS region
    # dynamodb_table = "your-terraform-lock-table"   # Replace with your DynamoDB table for state locking
    encrypt        = false                          # Enable server-side encryption of the state file
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.55.0" # or use a stable version if the latest has issues
    }
  }
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
