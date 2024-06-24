variable "repository_name" {
  description = "The name of the ECR repository"
  type        = string
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
  default = []
}
