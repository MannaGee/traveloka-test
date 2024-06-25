variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "use_ec2" {
  description = "Boolean to decide if EC2 should be used"
  type        = bool
  default     = true
}

variable "security_groups" {
  description = "List of security group IDs for the ASG"
  type        = list(string)
}

variable "ec2_ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
}

variable "key_name" {
  description = "Key name for SSH access"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM instance profile for the EC2 instances"
  type        = string
}

variable "associate_public_ip_address" {
  description = "Associate public IP address with instances"
  type        = bool
  default     = true
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ASG"
  type        = list(string)
}

variable "min_size" {
  description = "Minimum size of the ASG"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum size of the ASG"
  type        = number
  default     = 3
}

variable "desired_capacity" {
  description = "Desired capacity of the ASG"
  type        = number
  default     = 1
}

variable "health_check_grace_period" {
  description = "Health check grace period for the ASG"
  type        = number
  default     = 300
}

variable "maximum_scaling_step_size" {
  description = "Maximum step size for scaling"
  type        = number
  default     = 1
}

variable "minimum_scaling_step_size" {
  description = "Minimum step size for scaling"
  type        = number
  default     = 1
}

variable "scaling_status" {
  description = "Managed scaling status"
  type        = string
  default     = "ENABLED"
}

variable "target_capacity" {
  description = "Target capacity for scaling"
  type        = number
  default     = 100
}

variable "managed_termination_protection" {
  description = "Managed termination protection"
  type        = string
  default     = "DISABLED"
}
