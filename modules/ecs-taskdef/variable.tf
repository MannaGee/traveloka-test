variable "family" {
  description = "A unique name for your task definition"
  type        = string
}

variable "container_definitions" {
  description = "A list of valid container definitions"
  type        = string
}

variable "use_fargate" {
  description = "Boolean to decide if Fargate should be used"
  type        = bool
  default     = false
}

variable "network_mode" {
  description = "The Docker networking mode to use for the containers in the task"
  type        = string
  default     = "bridge"
}

variable "requires_compatibilities" {
  description = "A set of launch types required by the task"
  type        = list(string)
}

variable "cpu" {
  description = "The number of CPU units used by the task"
  type        = string
}

variable "memory" {
  description = "The amount of memory (in MiB) used by the task"
  type        = string
}

variable "execution_role_arn" {
  description = "The ARN of the IAM role that allows your Amazon ECS container agent to make calls to the required AWS APIs on your behalf"
  type        = string
}

variable "task_role_arn" {
  description = "The ARN of the IAM role that containers in this task can assume"
  type        = string
}