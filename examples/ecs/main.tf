provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = "~> 1.7.3"
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
      version = ">= 5.46.0" # or use a stable version if the latest has issues
    }
  }
  
}

module "ecs_cluster" {
  source                 = "../../modules/ecs-cluster"
  cluster_name           = var.cluster_name
  use_ec2                = var.use_ec2
  ec2_ami_id             = var.ec2_ami_id 
  instance_type          = var.instance_type
  iam_instance_profile   = var.iam_instance_profile
  security_groups        = var.security_groups
  key_name               = var.key_name
  subnet_ids             = var.subnet_ids 
  desired_capacity       = var.desired_capacity
  max_size               = var.max_size
  min_size               = var.min_size
  associate_public_ip_address = var.associate_public_ip_address
  health_check_grace_period   = var.health_check_grace_period
}

# module "ecs_service" {
#   source             = "../../modules/ecs-service"
#   service_name       = var.service_name
#   container_name     = var.container_name
#   use_fargate        = var.use_fargate
#   cluster_id         = module.ecs_cluster.cluster_id
#   container_port     = var.container_port
#   security_group_ids = var.security_group_ids
#   task_definition    = module.ecs_task.task_definition_arn
#   subnet_ids         = var.subnet_ids
#   desired_count      = var.desired_count
#   target_group_arn   = var.target_group_arn   
# }

module "ecs_task" {
  source                   = "../../modules/ecs-taskdef"
  family                   = var.family
  use_fargate              = var.use_fargate  
  task_role_arn            = var.task_role_arn
  container_definitions    = var.container_definitions
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.execution_role_arn
  requires_compatibilities = var.requires_compatibilities
}
