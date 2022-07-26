variable "name" {
  type = string
  description = "Amazon MQ broker name"
}

variable "users" {
  type = list(object({
    username = string
    password = string
  }))
  description = "List of Amazon MQ users (username, password), only one for RabbitMQ"
  default = []
}

variable "vpc_id" {
  type = string
  description = "The VPC ID"
}

variable "subnet_ids" {
  type = set(string)
  description = "The subnet IDs for the MQ broker (1 subnet for SINGLE_INSTANCE)"
}

variable "private_subnets_cidr_blocks" {
  type = set(string)
  description = "The private subnet CIDR blocks for the MQ broker"
}

variable "apply_immediately" {
  type = bool
  description = "Whether to apply the changes immediately or during the next maintenance window"
  default = false
}

variable "tags" {
  type = map(string)
  description = "Tags to apply to the MQ broker"
  default = {}
}