variable "repository_name" {
  description = "The name of the ECR repository"
  type        = string
  default = "gha-test-repo"
}

variable "tags" {
  description = "A map of tags to assign to the ECR repository"
  type        = map(string)
  default     = {}
}

variable "enable_encryption" {
  description = "Enable encryption for the ECR repository"
  type        = bool
  default     = false
}

variable "enable_image_scanning" {
  description = "Enable image scanning on push for the ECR repository"
  type        = bool
  default     = false
}

variable "lifecycle_policy_rules" {
  description = "List of lifecycle policy rules for the ECR repository"
  type        = list(object({
    rule_priority = number
    description   = string
    tag_status    = string
    count_type    = string
    count_unit    = string
    count_number  = number
    action_type   = string
  }))
  default = [
    {
      rule_priority = 1
      description   = "Retain only the last 10 images"
      tag_status    = "any"
      count_type    = "imageCountMoreThan"
      count_unit    = "images"
      count_number  = 10
      action_type   = "expire"
    },
    {
      rule_priority = 2
      description   = "Retain untagged images for 30 days"
      tag_status    = "untagged"
      count_type    = "sinceImagePushed"
      count_unit    = "days"
      count_number  = 30
      action_type   = "expire"
    }
  ]
}
