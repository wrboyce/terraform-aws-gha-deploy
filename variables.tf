variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "project" {
  type        = string
  description = "The project identifier to use for this website"
}

variable "policy" {
  type        = string
  description = "AWS IAM Policy document"
}

variable "github_repo" {
  type        = string
  description = "GitHub repository"
}

variable "default_branch" {
  type        = string
  description = "Default repo branch"
  default     = "master"
}
