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


resource "aws_ecs_cluster" "custom-ecs-cluster" {
  name = var.cluster_name
}

resource "aws_launch_template" "ecs_instance_template" {
  count = var.use_ec2 ? 1 : 0

  name          = "${var.cluster_name}-template"
  image_id      = var.ec2_ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = var.associate_public_ip_address
    security_groups             = var.security_groups
  }

  iam_instance_profile {
    name = var.iam_instance_profile
  }

  # user_data = base64encode(data.template_file.ecs_user_data.rendered)

  lifecycle {
    create_before_destroy = true
  }
}

# data "template_file" "ecs_user_data" {
#   template = file("${path.module}/ecs-user-data.sh")
# }


# Auto Scaling Group
resource "aws_autoscaling_group" "custom-ecs-asg" {
  count                  = var.use_ec2 ? 1 : 0
  desired_capacity       = var.desired_capacity
  max_size               = var.max_size
  min_size               = var.min_size
  vpc_zone_identifier    = var.subnet_ids
  health_check_grace_period = var.health_check_grace_period

  launch_template {
    id      = aws_launch_template.ecs_instance_template[0].id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.cluster_name}-instance"
    propagate_at_launch = true
  }

  tag {
    key                 = "Cluster"
    value               = var.cluster_name
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}


# ECS Capacity Provider
resource "aws_ecs_capacity_provider" "ec2_provider" {
  count = var.use_ec2 ? 1 : 0

  name = "${var.cluster_name}-ec2-provider"
  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.custom-ecs-asg[0].arn
    managed_scaling {
      maximum_scaling_step_size = var.maximum_scaling_step_size
      minimum_scaling_step_size = var.minimum_scaling_step_size
      status                    = var.scaling_status
      target_capacity           = var.target_capacity
    }
    managed_termination_protection = var.managed_termination_protection
  }
}


output "cluster_id" {
  value = aws_ecs_cluster.custom-ecs-cluster.id
}

output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = aws_ecs_cluster.custom-ecs-cluster.name
}

output "asg_id" {
  description = "The ID of the Auto Scaling Group"
  value       = aws_autoscaling_group.custom-ecs-asg[0].id
}

output "launch_template_id" {
  description = "The ID of the Launch Template"
  value       = aws_launch_template.ecs_instance_template[0].id
}


