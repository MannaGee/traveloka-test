provider "aws" {
  region = "us-east-1"
}

resource "aws_ecr_repository" "custom-ecr" {
  name = var.repository_name

  tags = var.tags

  dynamic "encryption_configuration" {
    for_each = var.enable_encryption ? [true] : []
    content {
      encryption_type = "AES256"
    }
  }

  dynamic "image_scanning_configuration" {
    for_each = var.enable_image_scanning ? [true] : []
    content {
      scan_on_push = true
    }
  }
}

resource "aws_ecr_lifecycle_policy" "custom-ecr-policy" {
  repository = aws_ecr_repository.custom-ecr.name

  policy = jsonencode({
    rules = var.lifecycle_policy_rules 
  })
}

