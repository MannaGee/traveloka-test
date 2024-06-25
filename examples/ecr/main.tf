module "ecr" {
  source = "../../modules/ecr"

  repository_name       = var.repository_name
  tags                  = var.tags
  enable_encryption     = var.enable_encryption
  enable_image_scanning = var.enable_image_scanning
  lifecycle_policy_rules = var.lifecycle_policy_rules
}